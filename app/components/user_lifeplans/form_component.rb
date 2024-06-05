# frozen_string_literal: true

class UserLifeplans::FormComponent < ApplicationComponent
  attr_reader :user_lifeplan
  attr_reader :current_user
  attr_reader :form

  def initialize(**args)
    @user_lifeplan = args[:user_lifeplan]
    @current_user = args[:current_user]
    @form = args[:form]
  end

  def decorator_model
    eval("#{controller_name.singularize}".camelize + "Decorator")
  end

  def object_name
    controller_name.singularize
  end

  def start_pension_age_year
    return nil if current_user_age.blank?

    diff = user_lifeplan.start_pension_age - current_user_age
    current_year + diff
  end

  def start_resident_elderly_facility_age_year
    return nil if current_user_age.blank?

    diff = user_lifeplan.start_resident_elderly_facility_age - current_user_age
    current_year + diff
  end

  def start_nursing_care_age_year
    return nil if current_user_age.blank?

    diff = user_lifeplan.start_nursing_care_age - current_user_age
    current_year + diff
  end

  def death_age_year
    return nil if current_user_age.blank?

    diff = user_lifeplan.death_age - current_user_age
    current_year + diff
  end

  private

  def current_user_age
    user_lifeplan.user.age
  end

  def current_year
    Time.current.year
  end
end
