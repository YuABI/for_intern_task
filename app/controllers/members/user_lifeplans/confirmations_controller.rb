class Members::UserLifeplans::ConfirmationsController < Members::MasterSearchController

  def show
  end

  # 申請処理
  def update
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
