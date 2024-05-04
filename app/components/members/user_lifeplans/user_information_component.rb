# frozen_string_literal: true

class Members::UserLifeplans::UserInformationComponent < Members::BaseComponent
  attr_reader :user_lifeplan_decorator

  def initialize(**args)
    super(**args)

    @user_lifeplan_decorator = args[:user_lifeplan_decorator]
  end
end
