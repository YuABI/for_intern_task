class Admin::UserLifeplansController < Admin::MasterSearchController
  def show
    super
    @user_lifeplan_yearly_blance = UserLifeplan::YearlyBalance.new(user_lifeplan_custom_id: params_id)
    @user_lifeplan_yearly_blance.calculate
  end

  def create
    goto = "edit_admin_user_lifeplan_url"
    super(goto)
  end

  def update
    goto = if params[:confirm].present?
             "admin_user_lifeplan_url('#{params[:id]}')"
           else
             "edit_admin_user_lifeplan_url('#{params[:id]}')"
           end
    super(goto)
  end

  def add_user_lifeplan_asset
    add_associations(association_model: :user_lifeplan_assets)
  end

  def del_user_lifeplan_asset
    del_associations(association_model: :user_lifeplan_assets)
  end

  def add_user_lifeplan_income
    add_associations(association_model: :user_lifeplan_incomes)
  end

  def del_user_lifeplan_income
    del_associations(association_model: :user_lifeplan_incomes)
  end

  def add_user_lifeplan_expense
    add_associations(association_model: :user_lifeplan_expenses)
  end

  def del_user_lifeplan_expense
    del_associations(association_model: :user_lifeplan_expenses)
  end

  def add_user_lifeplan_finance_condition
    add_associations(association_model: :user_lifeplan_finance_conditions)
  end

  def del_user_lifeplan_finance_condition
    del_associations(association_model: :user_lifeplan_finance_conditions)
  end

  def add_user_lifeplan_contact
    add_associations(association_model: :user_lifeplan_contacts)
  end

  def del_user_lifeplan_contact
    del_associations(association_model: :user_lifeplan_contacts)
  end

  def add_user_lifeplan_beneficiary
    add_associations(association_model: :user_lifeplan_beneficiaries)
  end

  def del_user_lifeplan_beneficiary
    del_associations(association_model: :user_lifeplan_beneficiaries)
  end

  private

  def add_associations(**args)
    obj = find_or_initialize_object
    obj.assign_attributes(admin_object_params)
    association_model = args[:association_model]

    render_javascript do |page|
      obj.send(association_model).build
      page.replace_html('form', partial: 'form')
    end
  rescue StandardError => e
    LoggerService.new(exception: e, request:).call
  end

  def del_associations(**args)
    obj = find_or_initialize_object
    association_model = args[:association_model]

    options = admin_object_params

    options[:"#{association_model}_attributes"][params[:target_idx]][:_destroy] = '1'

    obj.assign_attributes(options)
    render_javascript do |page|
      page.replace_html('form', partial: 'form')
    end
  rescue StandardError => e
    LoggerService.new(exception: e, request:).call
  end

  def admin_object_params
    origin_params = super
    if origin_params[:contact_note_docs].present?
      origin_params[:contact_note_docs] = origin_params[:contact_note_docs].uniq
    end
    origin_params[:user_lifeplan_contacts_attributes]&.each do |i, child_attr|
      if child_attr[:docs].present?
        origin_params[:user_lifeplan_contacts_attributes][i][:docs] = child_attr[:docs].uniq
      end
    end
    origin_params[:user_lifeplan_finance_conditions_attributes]&.each do |i, child_attr|
      if child_attr[:docs].present?
        origin_params[:user_lifeplan_finance_conditions_attributes][i][:docs] = child_attr[:docs].uniq
      end
    end

    origin_params
  end
end
