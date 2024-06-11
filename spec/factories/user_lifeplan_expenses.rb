# == Schema Information
#
# Table name: user_lifeplan_expenses
#
#  id                         :bigint           not null, primary key
#  company_name               :string           default(""), not null
#  content                    :string           default(""), not null
#  deleted                    :integer          default(0), not null
#  deleted_at                 :datetime
#  expenditure_item_name      :string           default(""), not null
#  monthly_amount             :integer          default(0), not null
#  name                       :string           default(""), not null
#  note                       :string           default(""), not null
#  pay_by_years               :integer          default(1), not null
#  payment_end_year           :integer          default(2024), not null
#  payment_start_year         :integer          default(2024), not null
#  spending_item              :string           default(NULL), not null
#  user_lifeplan_expense_kind :string           default(NULL), not null
#  yearly_amount              :integer          default(0), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  user_lifeplan_id           :bigint           not null
#
# Indexes
#
#  index_user_lifeplan_expenses_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
FactoryBot.define do
  factory :user_lifeplan_expense do
    association :user_lifeplan
    name { Faker::Commerce.product_name }
    expenditure_item_name { Faker::Commerce.department }
    content { Faker::Lorem.sentence }
    company_name { Faker::Company.name }
    note { Faker::Lorem.paragraph }
    payment_start_on { Faker::Date.backward(days: 365) }
    payment_end_on { Faker::Date.forward(days: 365) }
    monthly_amount { Faker::Number.between(from: 1000, to: 10000) }
    pay_by_years { Faker::Number.between(from: 1, to: 10) }
    yearly_amount { monthly_amount * 12 }
    user_lifeplan_expense_kind { ["fixed", "variable"].sample } # Assume you have kinds like these.
    spending_item { Faker::Commerce.material }
  end
end
