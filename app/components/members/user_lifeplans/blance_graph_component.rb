# frozen_string_literal: true

class Members::UserLifeplans::BlanceGraphComponent < Members::BaseComponent
  attr_reader :user_lifeplan_decorator, :user_lifeplan_yearly_blance

  def initialize(**args)
    super(**args)

    @user_lifeplan_decorator = args[:user_lifeplan_decorator]
    @user_lifeplan_yearly_blance = args[:user_lifeplan_yearly_blance]
  end
end
