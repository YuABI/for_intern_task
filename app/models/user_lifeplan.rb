# == Schema Information
#
# Table name: user_lifeplans
#
#  id                                  :bigint           not null, primary key
#  background_reason                   :string           default(NULL), not null
#  background_reason_comment           :string           default(""), not null
#  basis_on                            :date
#  close_grave                         :string           default(NULL), not null
#  contact_inspect_note                :text
#  contact_note                        :text
#  death_age                           :integer          default(90), not null
#  deleted                             :integer          default(0), not null
#  deleted_at                          :datetime
#  funeral_memorial_policy             :string           default(NULL), not null
#  household_disposal                  :string           default(NULL), not null
#  legal_heir                          :string           default(NULL), not null
#  legal_heir_comment                  :string           default(NULL), not null
#  name                                :string           default(""), not null
#  note                                :string           default(""), not null
#  real_estate_disposal                :string           default(NULL), not null
#  relatives                           :string           default(NULL), not null
#  relatives_comment                   :string           default(NULL), not null
#  residue                             :string           default(NULL), not null
#  review_completed_at                 :datetime
#  review_requested_at                 :datetime
#  review_started_at                   :integer
#  small_account                       :string           default(""), not null
#  start_nursing_care_age              :integer          default(85), not null
#  start_pension_age                   :integer          default(65), not null
#  start_resident_elderly_facility_age :integer          default(80), not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  admin_user_id                       :bigint
#  member_id                           :bigint           not null
#  user_id                             :bigint           not null
#  user_lifeplan_status_id             :integer          default(1), not null
#
# Indexes
#
#  index_user_lifeplans_on_admin_user_id  (admin_user_id)
#  index_user_lifeplans_on_member_id      (member_id)
#  index_user_lifeplans_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_user_id => admin_users.id)
#  fk_rails_...  (user_id => users.id)
#
class UserLifeplan < ApplicationRecord
  belongs_to :user
  belongs_to :member
  belongs_to :admin_user, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user_lifeplan_status

  has_many :user_lifeplan_beneficiaries, dependent: :destroy
  has_many :user_lifeplan_contacts, dependent: :destroy
  has_many :user_lifeplan_finance_conditions, dependent: :destroy
  has_many :user_lifeplan_incomes, dependent: :destroy
  has_many :user_lifeplan_expenses, dependent: :destroy
  has_many :user_lifeplan_assets, dependent: :destroy
  has_many :user_lifeplan_remand_histories, dependent: :destroy

  accepts_nested_attributes_for :user_lifeplan_beneficiaries, allow_destroy: true
  accepts_nested_attributes_for :user_lifeplan_contacts, allow_destroy: true
  accepts_nested_attributes_for :user_lifeplan_finance_conditions, allow_destroy: true
  accepts_nested_attributes_for :user_lifeplan_incomes, allow_destroy: true
  accepts_nested_attributes_for :user_lifeplan_expenses, allow_destroy: true
  accepts_nested_attributes_for :user_lifeplan_assets, allow_destroy: true
  has_many_attached :contact_note_docs

  enumerize :background_reason, in: %i[unselected no_children children_issues family_domestic_violence
                                       family_squandering no_burden_on_family], default: :unselected
  enumerize :legal_heir, in: %i[unselected existing not_existing], default: :unselected
  enumerize :legal_heir_comment, in: %i[unselected cooperative no_issues problematic_background estranged_unknown],
            default: :unselected
  enumerize :residue, in: %i[unselected existing not_existing], default: :unselected
  enumerize :relatives, in: %i[unselected existing not_existing], default: :unselected
  enumerize :relatives_comment, in: %i[unselected cooperative no_issues problematic_background estranged_unknown],
            default: :unselected
  enumerize :household_disposal, in: %i[unselected existing not_existing checking], default: :unselected
  enumerize :real_estate_disposal, in: %i[unselected existing not_existing checking], default: :unselected
  enumerize :close_grave, in: %i[unselected existing not_existing checking], default: :unselected
  enumerize :funeral_memorial_policy, in: %i[unselected decided checking], default: :unselected

  attribute :start_pension_age, default: -> { 65 }
  attribute :start_resident_elderly_facility_age, default: -> { 80 }
  attribute :start_nursing_care_age, default: -> { 85 }
  attribute :death_age, default: -> { 90 }

  class << self
    def permit_params
      super +
        [
          contact_note_docs: [],
          user_lifeplan_assets_attributes: UserLifeplanAsset.permit_params,
          user_lifeplan_incomes_attributes: UserLifeplanIncome.permit_params,
          user_lifeplan_expenses_attributes: UserLifeplanExpense.permit_params,
          user_lifeplan_beneficiaries_attributes: UserLifeplanBeneficiary.permit_params,
          user_lifeplan_contacts_attributes: UserLifeplanContact.permit_params,
          user_lifeplan_finance_conditions_attributes: UserLifeplanFinanceCondition.permit_params,
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

  def request_review
    return false if !user_lifeplan_status.entering?

    self.review_requested_at = Time.current
    self.user_lifeplan_status_id = UserLifeplanStatus.find_by(code: 'check_pending').id
    save
  end

  def remand_review(new_admin_user = nil)
    return false  if !user_lifeplan_status.check_pending?

    new_admin_user_id = new_admin_user_id || admin_user_id
    self.admin_user_id = new_admin_user.id
    self.user_lifeplan_status_id = UserLifeplanStatus.find_by(code: 'entering').id
    user_lifeplan_remand_histories.build(remanded_at: Time.current, admin_user_id: new_admin_user.id)
    save
  end

  def complete_review(new_admin_user = nil)
    return false if !user_lifeplan_status.check_pending?

    new_admin_user_id = new_admin_user.id || admin_user_id
    self.admin_user_id = new_admin_user_id
    self.review_completed_at = Time.current
    self.user_lifeplan_status_id = UserLifeplanStatus.find_by(code: 'check_completed').id
    save
  end
end
