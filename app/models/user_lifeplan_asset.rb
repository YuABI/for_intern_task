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
class UserLifeplanAsset < ApplicationRecord
  belongs_to :user_lifeplan
  attribute :reference_on, default: -> { Time.current.to_date }

  enumerize :user_lifeplan_asset_kind, in: %i[cash_deposits other_assets], scope: true, predicates: true
  enumerize :cache_deposit_kind, in: %i[
    ordinary_deposit standard_savings regular_savings fixed_deposit fixed_amount_savings time_deposit savings_deposit
    installment_savings transfer_account investment_fund other_cache_deposit unselected
  ], default: :unselected
  enumerize :other_assets_kind, in: %i[
    land building condominium securities life_insurance property_insurance loan deposit other_assets unselected
  ], default: :unselected

  attribute :rate, default: -> { 1 }
  attribute :scheduled_for_sale, default: -> { Time.current.year }


  class << self
    def permit_params
      super
    end
  end
end
