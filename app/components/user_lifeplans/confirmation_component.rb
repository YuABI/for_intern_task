# frozen_string_literal: true

class UserLifeplans::ConfirmationComponent < ApplicationComponent
  attr_reader :user_lifeplan, :decorator_model, :current_user, :user_lifeplan_yearly_blance

  def initialize(**args)
    @user_lifeplan = args[:user_lifeplan]
    @decorator_model = args[:decorator_model]
    @current_user = args[:current_user]
    @user_lifeplan_yearly_blance = args[:user_lifeplan_yearly_blance]
  end
end
