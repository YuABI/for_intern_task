class Members::UserLifeplansController < Members::MasterSearchController
  def show
    super
    @user_lifeplan_yearly_blance = UserLifeplan::YearlyBalance.new(user_lifeplan_custom_id: params_id)
    @user_lifeplan_yearly_blance.calculate
  end

  def new
    super

    @user_lifeplan.setup_contacts
    @user_lifeplan.setup_user(params[:user_id]) if params[:user_id].present?
  end

  def create
    goto = "edit_members_user_lifeplan_url"
    super(goto)
  end

  def update
    goto = if params[:confirm].present?
             "members_user_lifeplan_url('#{params[:id]}')"
           else
             "edit_members_user_lifeplan_url('#{params[:id]}')"
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
    obj.assign_attributes(members_object_params)
    association_model = args[:association_model]

    render_javascript do |page|
      obj.send(association_model).build(association_model_params)
      page.replace_html('form', partial: 'form')
    end
  rescue StandardError => e
    LoggerService.new(exception: e, request:).call
  end

  def del_associations(**args)
    obj = find_or_initialize_object
    association_model = args[:association_model]

    options = members_object_params

    options[:"#{association_model}_attributes"][params[:target_idx]][:_destroy] = '1'

    obj.assign_attributes(options)
    render_javascript do |page|
      page.replace_html('form', partial: 'form')
    end
  rescue StandardError => e
    LoggerService.new(exception: e, request:).call
  end

  def members_object_params
    origin_params = super
    if origin_params[:member_id].blank?
      origin_params[:member_id] = @current_member.id
    end
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

  def association_model_params
    params[:association_model_params]&.permit(
      :user_lifeplan_asset_kind, :user_lifeplan_income_kind, :user_lifeplan_expense_kind,
      :finance_condition_kind
    )
  end
end
