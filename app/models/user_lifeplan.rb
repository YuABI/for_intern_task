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

  class << self
    def permit_params
      %i[name status apply_reviewed_at reviewed_at]
    end
  end
end
