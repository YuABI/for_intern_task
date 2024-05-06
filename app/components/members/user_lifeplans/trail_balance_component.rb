# frozen_string_literal: true

class Members::UserLifeplans::TrailBalanceComponent < Members::BaseComponent
  attr_reader :user_lifeplan_decorator
  attr_reader :user_lifeplan_yearly_blance

  def initialize(**args)
    super(**args)

    @user_lifeplan_decorator = args[:user_lifeplan_decorator]
    @user_lifeplan_yearly_blance = args[:user_lifeplan_yearly_blance]
  end

  def sum_each_amount(*arg)
    total = 0
    arg.each do |each_amount|
      total = total + each_amount
    end

    total
  end

  def change_delimited(number)
    return '-' if number.blank? || number.zero?

    number_to_currency(number, unit: '', precision: 0)
  end
end
