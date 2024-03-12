module ApiWrapperSetting
  extend ActiveSupport::Concern
  included do
    has_many :api_results, as: :target
  end

  def api_after_initialize_setup; end

  def to_api_wrapper
    ActiveType.cast(self, self.class::ApiWrapper)
  end

  def api_save
    success = false
    _errors = standard_transaction do
      success = standard_save
      success = yield(success) if block_given?
      raise unless success
    end
    success
  end

  def api_create
    api_after_initialize_setup
    api_save
  end

  def api_update(**_args)
    api_after_initialize_setup
    api_save
  end

  def api_valid?(**args)
    api_after_initialize_setup
    standard_valid?(**args)
  end

  def api_destroy
    safe_destroy
  end

  def set_association(options = {})
    options
  end

  def create_after_association(_association, _error_messages = [])
    _error_messages
  end

  def update_after_association(_association, _error_messages = [])
    _error_messages
  end

  def create_after_associations
    []
  end

  def update_after_associations
    []
  end

  def api_create_associations(association_model, **_args)
    association_table_name = association_model.to_s.pluralize
    association_attributes = send("#{association_model}_attributes")

    return true if association_attributes.blank?

    _error_messages = []
    _errors = standard_transaction do
      association_attributes.each do |association_attribute|
        _association = self.send(association_table_name).build(
          set_association(association_attribute)
        ).to_api_wrapper

        _error_messages << _association.generate_error_messages.join('、') unless _association.api_save
        _error_messages = create_after_association(_association, _error_messages)
      end

      raise if _error_messages.present?

      _error_messages = create_after_associations
      raise if _error_messages.present?

      true
    end

    if _error_messages.present?
      self.errors.add(:"#{association_table_name}", _error_messages.join('、'))
      return false
    end

    if _errors.present?
      self.errors.add(:"#{association_table_name}", _errors.join('、'))
      return false
    end

    reload
    true
  end

  def api_update_associations(association_model, **_args)
    association_table_name = association_model.to_s.pluralize
    association_attributes = send("#{association_model}_attributes")

    return true if association_attributes.blank?

    _error_messages = []
    _errors = standard_transaction do
      association_attributes.each do |association_attribute|
        _association = self.send(association_table_name).find_by(id: association_attribute[:id])
        _error_messages << "ID:#{association_attribute[:id]}が存在しません" and next unless _association

        _association = _association.to_api_wrapper
        _association.assign_attributes(association_attribute)

        _error_messages << _association.generate_error_messages.join('、') and next unless _association.api_save

        _error_messages = update_after_association(_association, _error_messages)
      end
      _error_messages << self.generate_error_messages.join('、') unless api_save
      raise if _error_messages.present?

      reload
      _error_messages = update_after_associations
      raise if _error_messages.present?

      true
    end

    if _error_messages.present?
      self.errors.add(:"#{association_table_name}", _error_messages.join('、'))
      return false
    end

    if _errors.present?
      self.errors.add(:"#{association_table_name}", _errors.join('、'))
      return false
    end

    reload
    true
  end

  protected

  class_methods do
    def bulk_create(object_params)
      object_info = { success: [], failure: [], errors: [] }
      return object_info if object_params[:"#{table_name}"].blank?

      object_params[:"#{table_name}"].each do |object_params|
        _object_id = nil
        _error_msg = ''
        obj = self.new
        obj.assign_attributes(object_params)
        if obj.api_create
          _object_id = obj.id
        else
          _error_msg = obj.generate_error_messages.join('、')
        end
        object_info = bulk_info(_object_id, _error_msg, object_info)
      end
      object_info
    end

    def bulk_update(object_params)
      object_info = { success: [], failure: [], errors: [] }
      return object_info if object_params[:"#{table_name}"].blank?

      object_params[:"#{table_name}"].each do |object_params|
        _object_id = object_params[:id].to_i
        _error_msg = ''
        obj = self.find_by({ id: _object_id })
        if obj
          obj.assign_attributes(object_params)
          _error_msg = obj.generate_error_messages.join('、') unless obj.api_update
        else
          _error_msg = "#{object_params[:id]} not found"
        end
        object_info = bulk_info(_object_id, _error_msg, object_info)
      end
      object_info
    end

    def bulk_destroy(object_params)
      object_info = { success: [], failure: [], errors: [] }
      return object_info if object_params[:"#{table_name}"].blank?

      object_params[:"#{table_name}"].each do |object_params|
        _object_id = object_params[:id].to_i
        _error_msg = ''
        obj = self.find_by({ id: _object_id })
        if obj
          _error_msg = obj.generate_error_messages.join('、') unless obj.api_destroy
        else
          _error_msg = "#{object_params[:id]} not found"
        end
        object_info = bulk_info(_object_id, _error_msg, object_info)
      end
      object_info
    end

    def bulk_info(_object_id, _error_msg, object_info)
      if _error_msg.blank?
        object_info[:success] << _object_id
      else
        object_info[:failure] << _object_id
        object_info[:errors] << { id: _object_id, error_description: _error_msg }
      end
      object_info
    end

    def bulk_create_permit_params
      permit_params
    end

    def bulk_update_permit_params
      [
        :id,
      ] + permit_params
    end

    def bulk_destroy_permit_params
      [
        :id,
      ]
    end
  end
end
