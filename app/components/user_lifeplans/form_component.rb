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
end
