# frozen_string_literal: true

class UserLifeplans::Form::ExpensesComponent < ApplicationComponent
  attr_reader :user_lifeplan
  attr_reader :current_user
  attr_reader :form

  def initialize(**args)
    @user_lifeplan = args[:user_lifeplan]
    @current_user = args[:current_user]
    @form = args[:form]
  end

  def f
    form
  end

  def add_expense_url(association_model_params = {})
    if current_user.is_a?(AdminUser)
      add_user_lifeplan_expense_admin_user_lifeplans_path(
        id: user_lifeplan.exists_db? ? user_lifeplan.custom_id : nil,
        association_model_params: association_model_params
      )
    else
      add_user_lifeplan_expense_members_user_lifeplans_path(
        id: user_lifeplan.exists_db? ? user_lifeplan.custom_id : nil,
        association_model_params: association_model_params
      )
    end
  end

  def del_expense_url(target_idx: )
    if current_user.is_a?(AdminUser)
      del_user_lifeplan_expense_admin_user_lifeplans_path(
        id: user_lifeplan.exists_db? ? user_lifeplan.custom_id : nil,target_idx:
      )
    else
      del_user_lifeplan_expense_members_user_lifeplans_path(
        id: user_lifeplan.exists_db? ? user_lifeplan.custom_id : nil,target_idx:
      )
    end
  end

  def cell_min(cell_code)
    if %i[payment_start_year payment_end_year].include?(cell_code)
      "min-width: 100px;"
    elsif %i[monthly_amount yearly_amount pay_by_years].include?(cell_code)
      "min-width: 80px;"
    else
      "min-width: 150px;"
    end
  end
end
