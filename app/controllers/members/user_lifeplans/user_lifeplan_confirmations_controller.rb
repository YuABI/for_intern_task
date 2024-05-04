class Members::UserLifeplans::UserLifeplanConfirmationsController < Members::MasterSearchController

  def show
    super
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
