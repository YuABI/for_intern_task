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

  def cell_style(cell_code)
    style_txt = ''

    if %i[payment_start_year payment_end_year].include?(cell_code)
      style_txt = style_txt + "min-width: 100px;"
    elsif %i[monthly_amount yearly_amount pay_by_years].include?(cell_code)
      style_txt = style_txt + "min-width: 80px;"
    else
      style_txt = style_txt + "min-width: 150px;"
    end

    if %i[user_lifeplan_expense_kind].include?(cell_code.to_sym)
      style_txt = style_txt + 'position: sticky; top: 0; left: 0; z-index: 99;width: 150px;'
    elsif %i[spending_item expenditure_item_name].include?(cell_code.to_sym)
      style_txt = style_txt + 'position: sticky;z-index: 99; top: 0; left: 150px;'
    end

    style_txt
  end
end
