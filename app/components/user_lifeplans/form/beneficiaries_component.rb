# frozen_string_literal: true

class UserLifeplans::Form::BeneficiariesComponent < ApplicationComponent
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

  def add_beneficiary_url
    if current_user.is_a?(AdminUser)
      add_user_lifeplan_beneficiary_admin_user_lifeplans_path(id: user_lifeplan.exists_db? ? user_lifeplan.custom_id : nil)
    else
      add_user_lifeplan_beneficiary_members_user_lifeplans_path(id: user_lifeplan.exists_db? ? user_lifeplan.custom_id : nil)
    end
  end

  def del_beneficiary_url(target_idx: )
    if current_user.is_a?(AdminUser)
      del_user_lifeplan_beneficiary_admin_user_lifeplans_path(
        id: user_lifeplan.exists_db? ? user_lifeplan.custom_id : nil,target_idx:
      )
    else
      del_user_lifeplan_beneficiary_members_user_lifeplans_path(
        id: user_lifeplan.exists_db? ? user_lifeplan.custom_id : nil,target_idx:
      )
    end
  end
end
