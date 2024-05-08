# frozen_string_literal: true

class Members::UserLifeplans::DetailIncomeAndExpenseComponent < Members::BaseComponent
  attr_reader :user_lifeplan_decorator, :user_lifeplan_yearly_blance

  def initialize(**args)
    super(**args)

    @user_lifeplan_decorator = args[:user_lifeplan_decorator]
    @user_lifeplan_yearly_blance = args[:user_lifeplan_yearly_blance]
  end

  def year_with_unit(year)
    return '' if year.blank?

    "#{year}年"
  end

  def money_with_unit(number)
    return '' if number.blank?


    span_class = if number.negative?
                   'text-danger'
                  else
                    ''
                  end

    content_tag(:span, class: span_class) do
      number_to_currency(number, unit: '¥', precision: 0, format: "%u %n", negative_format: "%u -%n")
    end
  end

  def date_with_unit(date)
    return '' if date.blank?

    I18n.l(date)
  end

  def percent_with_unit(percent)
    return '' if percent.blank?

    "#{percent}%"
  end
end
