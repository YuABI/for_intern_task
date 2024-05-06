# == Schema Information
#
# Table name: user_lifeplan_incomes
#
#  id                        :bigint           not null, primary key
#  cache_income_kind         :string           default(NULL), not null
#  company_name              :string           default(""), not null
#  content                   :string           default(""), not null
#  deleted                   :integer          default(0), not null
#  deleted_at                :datetime
#  monthly_amount            :integer          default(0), not null
#  name                      :string           default(""), not null
#  payment_end_year          :integer
#  payment_start_year        :integer
#  pension_kind              :string           default(NULL), not null
#  user_lifeplan_income_kind :string           default(NULL), not null
#  yearly_amount             :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  user_lifeplan_id          :bigint           not null
#
# Indexes
#
#  index_user_lifeplan_incomes_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
FactoryBot.define do
  factory :user_lifeplan_income do
    association :user_lifeplan
    name { Faker::Company.name }
    user_lifeplan_income_kind { UserLifeplanIncome.user_lifeplan_income_kind.values.sample }
    pension_kind { UserLifeplanIncome.pension_kind.values.sample }
    cache_income_kind { UserLifeplanIncome.cache_income_kind.values.sample }
    content { Faker::Lorem.sentence }
    company_name { Faker::Company.name }
    payment_start_on { Faker::Date.between(from: 10.years.ago, to: 1.year.ago) }
    payment_end_on { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    monthly_amount { Faker::Number.between(from: 10000, to: 100000) }
    yearly_amount { monthly_amount * 12 }
  end
end
