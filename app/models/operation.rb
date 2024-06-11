class Operation < Base::BasicActiveModel
  attr_accessor :id, :code, :operation_category_id

  DATA_LIST = [
    { id: 100,  code: 'users',               operation_category_id: OperationCategory.user.id },
    { id: 100,  code: 'user_lifeplans',       operation_category_id: OperationCategory.user.id },
    { id: 200,  code: 'members',             operation_category_id: OperationCategory.member.id },
    { id: 250,  code: 'organizations',       operation_category_id: OperationCategory.member.id },
    { id: 300,  code: 'invoices',            operation_category_id: OperationCategory.invoice.id },
    { id: 400,  code: 'plans',               operation_category_id: OperationCategory.plan.id },
    { id: 410,  code: 'plan_options',        operation_category_id: OperationCategory.plan.id },
    { id: 450,  code: 'trust_companies',     operation_category_id: OperationCategory.plan.id },
    { id: 460,  code: 'insurance_companies', operation_category_id: OperationCategory.plan.id },
    { id: 500,  code: 'news',                operation_category_id: OperationCategory.content.id },
    { id: 510,  code: 'contents',            operation_category_id: OperationCategory.content.id },
    { id: 800,  code: 'admin_users',         operation_category_id: OperationCategory.setting.id },
    { id: 900,  code: 'system_configs',      operation_category_id: OperationCategory.setting.id },
    # { id: 500,  code: 'api_clients',        operation_category_id: OperationCategory.setting.id },
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
