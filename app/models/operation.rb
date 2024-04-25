class Operation < Base::BasicActiveModel
  attr_accessor :id, :code, :operation_category_id

  DATA_LIST = [
    { id: 100,  code: 'users',          operation_category_id: OperationCategory.user.id },
    { id: 200,  code: 'api_results',    operation_category_id: OperationCategory.history.id },
    { id: 300,  code: 'system_configs', operation_category_id: OperationCategory.setting.id },
    { id: 400,  code: 'admin_users',    operation_category_id: OperationCategory.setting.id },
    { id: 500,  code: 'api_clients',    operation_category_id: OperationCategory.setting.id },
    { id: 600,  code: 'user_lifeplans',    operation_category_id: OperationCategory.user.id },
  ].freeze
  def name
    I18n.t("activerecord.models.#{code.singularize}")
  end
  DATA_LIST.each do |code_data|
    define_method("#{code_data[:code]}?") do
      code == self.class.send(code_data[:code]).code
    end
  end

  class << self
    def base_data
      DATA_LIST
    end
    DATA_LIST.each do |code_data|
      define_method("#{code_data[:code]}") do
        find_by(code: code_data[:code])
      end
    end
  end
end
