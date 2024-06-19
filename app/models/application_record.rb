class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  extend Enumerize
  include Hashid::Rails
  include ValueComposable

  attr_accessor :target_config, :target_tmp_config, :target_cart_design, :target_object_type

  def to_default_class
    self.becomes(eval(self.class.table_name.singularize.camelize))
  end

  def set_all_config
    set_target_config
    set_target_tmp_config
  end

  def set_target_config
    self.target_config ||= SystemConfig.target_record
  end

  def system_datetime
    self.class.system_datetime
  end

  def system_date
    self.class.system_date
  end

  def standard_save
    save
  end

  def fixed_save!
    save!(context: :fixed)
  end

  def fixed_save
    save(context: :fixed)
  end

  def standard_save!
    save!
  end

  def skip_validate_save
    save(validate: false)
  end

  def standard_valid?(**args)
    no_err = valid?(args[:context])
    target_lists = args[:target] || []
    if target_lists.present?
      target_errors = target_lists.map do |target_list|
        msg = self.errors.messages[target_list.to_sym].first
        next if msg.blank?

        [target_list, msg]
      end.compact
      self.errors.clear
      no_err = target_errors.blank?
      target_errors.each do |error_list|
        self.errors.add(error_list.first, error_list.last)
      end
    end
    no_err
  end

  def standard_transaction(request = nil, &block)
    self.class.standard_transaction(request, &block)
  end

  def standard_update_columns(options)
    if new_record?
      self.attributes = options
      self.skip_validate_save
    else
      update_columns(options.merge(
                       updated_at: system_datetime
                     ))
    end
  end

  def exists_db?
    self.class.exists?(id)
  end

  def generate_error_message(attr)
    # return self.errors.full_messages_for(attr).first
    _error_messages = self.errors.messages[attr.to_sym]
    return nil if _error_messages.blank?

    _model, _code = if attr.to_s.include?('.')
                      attr.to_s.split('.')
                    else
                      [nil, attr]
                    end
    self.errors.full_messages_for(attr).first
  end

  def generate_error_messages
    self.errors.messages.map do |_message|
      _message = generate_error_message(_message.first)
    end.compact
  end

  def generate_error_messages_json(sym = self.class.table_name.singularize.to_sym)
    _json = { sym => {} }
    self.errors.messages.map do |_message|
      _json[sym][_message.first] = generate_error_message(_message.first)
    end.compact
    _json
  end

  def use_system?
    false
  end

  def allow_new?
    true
  end

  def allow_edit?
    true
  end

  def allow_delete?
    true
  end

  def safe_destroy
    if respond_to?(:deleted)
      self.deleted = self.class._deleted_
      skip_validate_save
    else
      destroy
    end
  end

  def _deleted_?
    !_alive_?
  end

  def _alive_?
    deleted == self.class._alive_
  end

  def deleted_human
    _alive_? ? '○' : '×'
  end

  def invalid_title
    self.class.invalid_title
  end

  def copy_attributes(new_object)
    self.class.column_names.each do |column|
      next if %w[id created_at updated_at].include?(column)

      new_object[column] = self[column] if new_object.class.column_names.include?(column)
    end
    new_object
  end

  def custom_id
    hashid
  end

  class << self
    def permit_params
      column_names + [
        :video_genre_id,
        :name,
        :attachment,
        :_destroy,

      ]
    end

    def system_datetime
      DateTime.now
    end

    def system_date
      system_datetime.to_date
    end

    def belongs_to_active_model(*args)
      args.each do |name|
        define_method(name) do
          name.to_s.classify.constantize.find_by(id: send("#{name}_id"))
        end
      end
    end

    def default_column(add_attributs = [])
      %w[id created_at updated_at deleted] + add_attributs
    end

    def human(sym)
      human_attribute_name(sym)
    end

    def update_id_sequence!
      self.connection.execute("SELECT setval('#{base_class.table_name}_id_seq', coalesce((SELECT MAX(id)+1 FROM #{base_class.table_name}), 1), false)")
    end

    def _alive_
      0
    end

    def _deleted_
      1
    end

    def _available_
      true
    end

    def _unavailable_
      false
    end

    def custom_find_by(options = {}, attr = {})
      object = self.find_by_hashid(options[:id])
      return nil unless object

      object.assign_attributes(attr || {})
      object
    end

    def alive_records
      return all unless column_names.include?('deleted')

      where(deleted: _alive_)
    end

    def deleted_records
      return all unless column_names.include?('deleted')

      where(deleted: _deleted_)
    end

    def available_records
      alive_records.where(available: _available_)
    end

    def alive_record(opt = {})
      if column_names.include?('deleted')
        opt[:deleted] = _alive_
      end
      find_by(opt)
    end

    def alive_record_or_initialize_by(options = {})
      if column_names.include?('deleted')
        options[:deleted] = _alive_
      end
      find_or_initialize_by(options)
    end

    def available_record(opt = {})
      opt[:available] = _available_
      alive_record(opt)
    end

    def build_sanitize_sql(sql_cond)
      sanitize_sql_array(sql_cond)
    end

    def standard_transaction(request = nil)
      errors__ = []
      transaction do
        yield
      rescue StandardError => e
        LoggerService.new(exception: e, request:).call
        if e.is_a? ActiveRecord::RecordInvalid
          errors__ << e.record.errors.messages.keys.map { |key| e.record.errors.messages[key] }
          errors__ << e if errors__.flatten.blank?
        else
          errors__ << e
        end
        raise ActiveRecord::Rollback
      end
      errors__.flatten
    end

    def invalid_title = '【緊急要対応エラー】'
  end
end
