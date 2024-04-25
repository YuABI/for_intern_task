# == Schema Information
#
# Table name: user_lifeplans
#
#  id                        :bigint           not null, primary key
#  apply_reviewed_at         :datetime
#  background_reason         :integer          default(0), not null
#  background_reason_comment :string           default(""), not null
#  close_grave               :integer          default(0), not null
#  deleted                   :integer          default(0), not null
#  deleted_at                :datetime
#  funeral_memorial_policy   :integer          default(0), not null
#  household_disposal        :integer          default(0), not null
#  legal_heir                :integer          default(0), not null
#  legal_heir_comment        :string           default(""), not null
#  name                      :string           default(""), not null
#  note                      :string           default(""), not null
#  real_estate_disposal      :integer          default(0), not null
#  relatives                 :integer          default(0), not null
#  relatives_comment         :string           default(""), not null
#  residue                   :integer          default(0), not null
#  reviewed_at               :datetime
#  small_account             :string           default(""), not null
#  status                    :integer          default(0), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class UserLifeplan < ApplicationRecord
  # TODO: まだUserができていないので、一旦コメントアウト
  # belongs_to :user
  has_many :user_lifeplan_beneficiaries, dependent: :destroy
  has_many :user_lifeplan_contacts, dependent: :destroy
  has_many :user_lifeplan_finance_conditions, dependent: :destroy
  has_many :user_lifeplan_incomes, dependent: :destroy
  has_many :user_lifeplan_expenses, dependent: :destroy
  has_many :user_lifeplan_assets, dependent: :destroy

  accepts_nested_attributes_for :user_lifeplan_beneficiaries, allow_destroy: true
  accepts_nested_attributes_for :user_lifeplan_contacts, allow_destroy: true
  accepts_nested_attributes_for :user_lifeplan_finance_conditions, allow_destroy: true
  accepts_nested_attributes_for :user_lifeplan_incomes, allow_destroy: true
  accepts_nested_attributes_for :user_lifeplan_expenses, allow_destroy: true
  accepts_nested_attributes_for :user_lifeplan_assets, allow_destroy: true

  class << self
    def permit_params
      %i[name status apply_reviewed_at reviewed_at background_reason background_reason_comment legal_heir
         legal_heir_comment residue relatives relatives_comment household_disposal real_estate_disposal
          close_grave funeral_memorial_policy small_account note] +
        [
          user_lifeplan_assets_attributes:
            %i[name user_lifeplan_id rate asset_kind financial_institution_name store_name deposit_kind account_number
               reference_at amount_of_money content company_name asset_number asset_appraisal_value
               equity_appraisal_value scheduled_for_sale sundry_expenses profit description],
          user_lifeplan_incomes_attributes:
            %i[name user_lifeplan_id income_kind asset_income_kind content company_name assets_number payment_start_at
               payment_end_at monthly_amount],
          user_lifeplan_expenses_attributes:
            %i[name expenditure_item_name user_lifeplan_id content company_name assets_number note payment_start_at
               payment_end_at monthly_amount pay_by_years yearly_amount]
        ]
    end
  end
end
