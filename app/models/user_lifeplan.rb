# == Schema Information
#
# Table name: user_lifeplans
#
#  id                        :bigint           not null, primary key
#  apply_reviewed_at         :datetime
#  background_reason         :string           default(NULL), not null
#  background_reason_comment :string           default(""), not null
#  close_grave               :string           default(NULL), not null
#  contact_inspect_note      :text
#  contact_note              :text
#  deleted                   :integer          default(0), not null
#  deleted_at                :datetime
#  funeral_memorial_policy   :string           default(NULL), not null
#  household_disposal        :string           default(NULL), not null
#  legal_heir                :string           default(NULL), not null
#  legal_heir_comment        :string           default(NULL), not null
#  name                      :string           default(""), not null
#  note                      :string           default(""), not null
#  real_estate_disposal      :string           default(NULL), not null
#  relatives                 :string           default(NULL), not null
#  relatives_comment         :string           default(NULL), not null
#  residue                   :string           default(NULL), not null
#  reviewed_at               :datetime
#  small_account             :string           default(""), not null
#  status                    :integer          default(0), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  member_id                 :bigint           not null
#  user_id                   :bigint           not null
#
# Indexes
#
#  index_user_lifeplans_on_member_id  (member_id)
#  index_user_lifeplans_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserLifeplan < ApplicationRecord
  belongs_to :user
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
  has_many_attached :contact_note_docs

  enumerize :background_reason, in: %i[unselected no_children children_issues family_domestic_violence
                                       family_squandering no_burden_on_family]
  enumerize :legal_heir, in: %i[unselected existing not_existing]
  enumerize :legal_heir_comment, in: %i[unselected cooperative no_issues problematic_background estranged_unknown]
  enumerize :residue, in: %i[unselected existing not_existing]
  enumerize :relatives, in: %i[unselected existing not_existing]
  enumerize :relatives_comment, in: %i[unselected cooperative no_issues problematic_background estranged_unknown]
  enumerize :household_disposal, in: %i[unselected existing not_existing checking]
  enumerize :real_estate_disposal, in: %i[unselected existing not_existing checking]
  enumerize :close_grave, in: %i[unselected existing not_existing checking]
  enumerize :funeral_memorial_policy, in: %i[unselected decided checking]

  class << self
    def permit_params
      %i[user_id name status apply_reviewed_at reviewed_at background_reason background_reason_comment legal_heir
         legal_heir_comment residue relatives relatives_comment household_disposal real_estate_disposal
         close_grave funeral_memorial_policy small_account note] +
        [
          user_lifeplan_assets_attributes: UserLifeplanAsset.permit_params,
          user_lifeplan_incomes_attributes: UserLifeplanIncome.permit_params,
          user_lifeplan_expenses_attributes: UserLifeplanExpense.permit_params,
          user_lifeplan_beneficiaries_attributes: UserLifeplanBeneficiary.permit_params,
          user_lifeplan_contacts_attributes: UserLifeplanContact.permit_params,
          user_lifeplan_finance_conditions_attributes: UserLifeplanFinanceCondition.permit_params
        ]
    end
  end

  def setup_contacts
    self.user_lifeplan_contacts = UserLifeplanContact.user_lifeplan_contact_kind.values.map do |key|
      UserLifeplanContact.new(user_lifeplan_contact_kind: key)
    end
  end

  def setup_user(user_hash_id)
      # TODO: memberとの紐付けが実装され次第、コメントアウトを外す
      # designated_user = users.find_by(id: params[:user_id])
      designated_user = User.find_by_hashid(user_hash_id)
      self.user_id = designated_user&.id
  end
end
