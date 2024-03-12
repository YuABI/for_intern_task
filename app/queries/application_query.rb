class ApplicationQuery
  include ActiveModel::Model
  include ActiveModel::Attributes
  class_attribute :_query_model_
  class_attribute :_like_attributes_
  class_attribute :_equal_attributes_
  class_attribute :_in_attributes_

  attribute :params # ,:string

  self._like_attributes_  = []
  self._equal_attributes_ = []
  self._in_attributes_    = []
  def initialize(attributes = {})
    super(attributes)
    self.params = attributes.to_h
  end

  def call(**options)
    paginate        = options[:paginate]
    admin_user      = options[:admin_user]
    condition       = options[:condition]
    save_condition  = condition == :save
    load_condition  = condition == :load

    query_options = self.params
    # sql_condition = SqlCondition.find_or_initialize_by(
    #   code:          _query_model_.to_s.underscore,
    #   admin_user_id: admin_user.try(:id)
    # )
    #
    # if save_condition
    #   sql_condition.condition = query_options
    #   sql_condition.save(validate: false)
    # end
    if load_condition && sql_condition
      self.attributes = sql_condition.to_query(self.dup.attributes.to_h)
    end

    relations = target_records
    _like_attributes_.each do |attr|
      relations = relations.where _query_model_.arel_table[attr].matches("%#{send(attr)}%") if send(attr).present?
    end
    _equal_attributes_.each do |attr|
      relations = relations.where _query_model_.arel_table[attr].eq(send(attr)) if send(attr).present?
    end
    _in_attributes_.each do |attr|
      send(attr).try(:reject!) { |c| c.to_s.empty? }
      next if send(attr).blank?

      relations = if send(attr).respond_to?(:each)
                    relations.where _query_model_.arel_table[attr].in(send(attr))
                  else
                    relations.where _query_model_.arel_table[attr].in([send(attr)])
                  end
    end
    relations = between_condtions(
      relations:,
      condition_infos: [
        [:date, self.class.date_attributes],
        [:integer, self.class.integer_attributes],
      ]
    )
    relations = multiple_condtions(
      relations:, condition_columns: self.class.multiple_attributes
    )

    relations = custom_hook(relations) if defined? custom_hook
    if paginate
      relations = relations.reorder(paginate[:order]) if paginate[:order]
      relations = relations.page(paginate[:page] || 1)
      relations = relations.per(paginate[:per]   || 20)
    end
    puts relations.to_sql

    relations
  rescue StandardError => e
    LoggerService.new(exception: e, request: nil).call
    []
  end

  def target_records
    self.class.target_records
  end

  def between_condtions(**args)
    relations         = args[:relations]
    condition_table   = args[:condition_table]
    condition_infos   = args[:condition_infos] || []
    condition_infos.each do |condition_info|
      condition_type = condition_info.first
      condition_info.last.each do |condition_column|
        _target       = send(condition_column)
        _target_from  = send("#{condition_column}_from")
        _target_to    = send("#{condition_column}_to")

        sql_sym, cast_sym = if condition_type == :date
                              ['::date', 'to_date']
                            else
                              ['::integer', 'to_i']
                            end
        if _target.present?
          relations = relations.where("#{"#{condition_table}." if condition_table}#{condition_column}#{sql_sym} = ? ",
                                      _target.to_s.send(cast_sym))
        end
        if _target_from.present?
          relations = relations.where("#{"#{condition_table}." if condition_table}#{condition_column}#{sql_sym} >= ? ",
                                      _target_from.to_s.send(cast_sym))
        end
        if _target_to.present?
          relations = relations.where("#{"#{condition_table}." if condition_table}#{condition_column}#{sql_sym} <= ? ",
                                      _target_to.to_s.send(cast_sym))
        end
      end
    end
    relations
  end

  def multiple_condtions(**args)
    relations         = args[:relations]
    condition_table   = args[:condition_table]
    condition_columns = args[:condition_columns] || []

    condition_columns.each do |condition_column|
      _target_multiple   = send(condition_column)
      _target_multiples  = send("#{condition_column}s")
      [_target_multiple, _target_multiples].each do |_target|
        next unless _target.present?

        _lists = (_target.is_a?(Array) ? _target : _target.to_s.to_lists).compact_blank
        if _lists.present?
          relations = relations.where("#{"#{condition_table}." if condition_table}#{condition_column} in (?) ",
                                      _lists)
        end
      end
    end
    relations
  end

  class << self
    delegate :permit_params, to: :_query_model_

    def date_permit_params(_date_params)
      _date_params.map { |i| [i, "#{i}_from".to_sym, "#{i}_to".to_sym] }.flatten
    end

    def multiple_permit_params(_in_params)
      _in_params.map { |i| [i, { "#{i}s".to_sym => [] }] }.flatten
    end

    def date_attributes
      []
    end

    def integer_attributes
      []
    end

    def multiple_attributes
      []
    end

    def inherited(child)
      child._query_model_ = child.name.gsub('Query', '').constantize
    end

    def query_model(attr)
      self._query_model_ = attr
    end

    def define_attribute(*attrs)
      attrs.each do |attr|
        if attr.respond_to?(:each)
          attr.each do |attr2|
            define_method attr2 do
              instance_variable_get(%(@#{attr2}))
            end
            define_method %(#{attr2}=) do |val|
              instance_variable_set(%(@#{attr2}), val)
            end
          end
        else
          define_method attr do
            instance_variable_get(%(@#{attr}))
          end
          define_method %(#{attr}=) do |val|
            instance_variable_set(%(@#{attr}), val)
          end
        end
      end
    end

    def like_attributes(*attrs)
      define_attribute attrs
      if attrs.respond_to?(:each)
        attrs.each do |attr|
          self._like_attributes_ += [attr]
        end
      else
        self._like_attributes_ += [attrs[0]]
      end
    end

    def equal_attributes(*attrs)
      define_attribute attrs
      if attrs.respond_to?(:each)
        attrs.each do |attr|
          self._equal_attributes_ += [attr]
        end
      else
        self._equal_attributes_ += [attrs[0]]
      end
    end

    def in_attributes(*attrs)
      define_attribute attrs
      if attrs.respond_to?(:each)
        attrs.each do |attr|
          self._in_attributes_ += [attr]
        end
      else
        self._in_attributes_ += [attrs[0]]
      end
    end

    def condition_clear(**options)
      if options[:admin_user]
        # sql_conditions = SqlCondition.where(
        #   code: _query_model_.to_s.underscore,
        #   admin_user_id: options[:admin_user].id
        # )
        # sql_conditions.delete_all
      end
      attr = {}
      new(attr)
    end

    def target_records
      _query_model_.alive_records.order(id: :desc)
    end

    def paginate_opt(opt = {}, action = 'index')
      opt.merge({
                  params: action.is_a?(Hash) ? action : { action: },
                  window: 5,
                  outer_window: 5,
                })
    end
  end
end
