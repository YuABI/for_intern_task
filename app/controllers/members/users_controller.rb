class Members::UsersController < Members::MasterSearchController

  def new
    super
    @user.user_address_setup
  end

  def add_associations(**args)
    obj = find_or_initialize_object
    obj.assign_attributes(member_object_params)
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

    options = member_object_params

    options[:"#{association_model}_attributes"][params[:target_idx]][:_destroy] = '1'

    obj.assign_attributes(options)
    render_javascript do |page|
      page.replace_html('form', partial: 'form')
    end
  rescue StandardError => e
    LoggerService.new(exception: e, request:).call
  end

  def add_address
    add_associations(association_model: :addresses)
  end

  def del_address
    del_associations(association_model: :addresses)
  end

  def create
    goto = if params[:user_counsel].present?
             "members_users_user_counsel_path"
           elsif params[:user_lifeplan].present?
              select_user_lifeplan_url
           else
             nil
           end
    super(goto)
  end

  def update
    goto = if params[:user_counsel].present?
             "members_users_user_counsel_path"
           elsif params[:user_lifeplan].present?
              select_user_lifeplan_url
           else
             nil
           end
    super(goto)
  end

  def user_counsel
    @user = User.custom_find_by(id: params[:id])
    UserCounsel.counseling_category.options.each do |k, v|
      @user.user_counsels.build(counseling_category: v)
    end
  end

  def find_object
    obj = _model_.custom_find_by({id: params[:id]})
    instance_set(name_singularize, obj)
    obj
  end

  private

  def select_user_lifeplan_url
    user = find_object
    last_user_lifeplan = user&.user_lifeplans&.order(:id)&.last

    if user.present? && last_user_lifeplan.present?
      "edit_members_user_lifeplan_path('#{last_user_lifeplan.custom_id}')"
    elsif user.present? && last_user_lifeplan.blank?
      "new_members_user_lifeplan_path(user_id: '#{user.custom_id}')"
    else
      'new_members_user_lifeplan_path()'
    end
  end
end
