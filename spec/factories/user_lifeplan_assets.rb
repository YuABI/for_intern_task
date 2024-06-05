# == Schema Information
#
# Table name: user_lifeplan_assets
#
#  id                         :bigint           not null, primary key
#  account_number             :string           default(""), not null
#  amount_of_money            :integer          default(0), not null
#  asset_appraisal_value      :integer          default(0), not null
#  cache_deposit_kind         :string           default(NULL), not null
#  company_name               :string           default(""), not null
#  content                    :string           default(""), not null
#  deleted                    :integer          default(0), not null
#  deleted_at                 :datetime
#  description                :string           default(""), not null
#  equity_appraisal_value     :integer          default(0), not null
#  financial_institution_name :string           default(""), not null
#  name                       :string           default(""), not null
#  other_assets_kind          :string           default(NULL), not null
#  profit                     :integer          default(0), not null
#  rate                       :integer          default(1), not null
#  reference_on               :date
#  scheduled_for_sale         :integer          default(2024), not null
#  store_name                 :string           default(""), not null
#  sundry_expenses            :integer          default(0), not null
#  user_lifeplan_asset_kind   :string           default(NULL), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  user_lifeplan_id           :bigint           not null
#
# Indexes
#
#  index_user_lifeplan_assets_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
FactoryBot.define do
  factory :user_lifeplan_asset do
    association :user_lifeplan
    name { Faker::Commerce.product_name }
    user_lifeplan_asset_kind { UserLifeplanAsset.user_lifeplan_asset_kind.values.sample }
    cache_deposit_kind { UserLifeplanAsset.cache_deposit_kind.values.sample }
    other_assets_kind { UserLifeplanAsset.other_assets_kind.values.sample }
    financial_institution_name { Faker::Bank.name }
    store_name { Faker::Company.name }
    account_number { Faker::Bank.account_number }
    reference_on { Faker::Date.between(from: 2.years.ago, to: Date.today) }
    amount_of_money { Faker::Number.number(digits: 5) }
    content { Faker::Lorem.sentence }
    company_name { Faker::Company.name }
    asset_appraisal_value { Faker::Number.number(digits: 5) }
    equity_appraisal_value { Faker::Number.number(digits: 5) }
    scheduled_for_sale { [0, 1].sample }
    sundry_expenses { Faker::Number.number(digits: 3) }
    profit { Faker::Number.number(digits: 3) }
    description { Faker::Lorem.paragraph }
  end
end
