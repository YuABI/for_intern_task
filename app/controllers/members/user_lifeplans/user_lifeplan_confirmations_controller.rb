class Members::UserLifeplans::UserLifeplanConfirmationsController < Members::MasterSearchController

  def show
    super
    @user_lifeplan_yearly_blance = UserLifeplan::YearlyBalance.new(user_lifeplan_custom_id: params_id)
    @user_lifeplan_yearly_blance.calculate
  end

  # 申請処理
  def update
    obj = find_object
  end

  private

  def name_singularize
    'user_lifeplan'
  end

  def name_pluralize
    name_singularize.pluralize
  end

  def params_id
    params[:user_lifeplan_id]
  end
end
