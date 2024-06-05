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
#  rate                       :integer          default(100), not null
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
    unselected ordinary_deposit standard_savings regular_savings fixed_deposit fixed_amount_savings time_deposit savings_deposit
    installment_savings transfer_account investment_fund other_cache_deposit
  ], default: :unselected
  enumerize :other_assets_kind, in: %i[
    unselected land building condominium securities life_insurance property_insurance loan deposit other_assets
  ], default: :unselected

  attribute :rate, default: -> { 100 }
  attribute :scheduled_for_sale, default: -> { Time.current.year }

  validates :name, exclusion: { in: [nil] }
  validates :rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :other_assets_kind, exclusion: { in: [nil] }
  validates :financial_institution_name, exclusion: { in: [nil] }
  validates :store_name, exclusion: { in: [nil] }
  validates :cache_deposit_kind, exclusion: { in: [nil] }
  validates :account_number, exclusion: { in: [nil] }
  validates :amount_of_money, numericality: { greater_than_or_equal_to: 0 }
  validates :content, exclusion: { in: [nil] }
  validates :company_name, exclusion: { in: [nil] }
  validates :asset_appraisal_value, numericality: { greater_than_or_equal_to: 0 }
  validates :equity_appraisal_value, numericality: { greater_than_or_equal_to: 0 }
  validates :scheduled_for_sale, numericality: { greater_than_or_equal_to: 0 }
  validates :sundry_expenses, numericality: { greater_than_or_equal_to: 0 }
  validates :profit, numericality: { greater_than_or_equal_to: 0 }
  validates :description, exclusion: { in: [nil] }



  class << self
    def permit_params
      super
    end
  end
end
