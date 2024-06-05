# frozen_string_literal: true

class UserLifeplans::DetailIncomeAndExpenseComponent < ApplicationComponent
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

  def asset_finance_conditions
    user_lifeplan_decorator.user_lifeplan_finance_conditions.with_finance_condition_kind(:asset)
  end

  def income_finance_conditions
    user_lifeplan_decorator.user_lifeplan_finance_conditions.with_finance_condition_kind(:income)
  end

  def expense_finance_conditions
    user_lifeplan_decorator.user_lifeplan_finance_conditions.with_finance_condition_kind(:expense)
  end

  def finance_condition_text(finance_condition)
    text = ''
    if finance_condition.account.present?
      text = text + "#{UserLifeplanFinanceCondition.human_attribute_name(:account)}\n#{finance_condition.account}"
    end
    if finance_condition.account_info.present?
      text = text + "\n\n#{UserLifeplanFinanceCondition.human_attribute_name(:account_info)}\n#{finance_condition.account_info}"
    end
    if finance_condition.content.present?
      text = text + "\n\n#{UserLifeplanFinanceCondition.human_attribute_name(:content)}\n#{finance_condition.content}"
    end

    simple_format(text)
  end
end
