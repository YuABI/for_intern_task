# == Schema Information
#
# Table name: user_lifeplans
#
#  id                                  :bigint           not null, primary key
#  apply_reviewed_at                   :datetime
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
#  reviewed_at                         :datetime
#  small_account                       :string           default(""), not null
#  start_nursing_care_age              :integer          default(85), not null
#  start_pension_age                   :integer          default(65), not null
#  start_resident_elderly_facility_age :integer          default(80), not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  member_id                           :bigint           not null
#  user_id                             :bigint           not null
#  user_lifeplan_status_id             :integer          default(1), not null
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
FactoryBot.define do
  factory :user_lifeplan do
    association :user
    name { Faker::Name.name }
    status { Faker::Number.between(from: 0, to: 5) }
    apply_reviewed_at { Faker::Time.between(from: 2.years.ago, to: Date.today) }
    reviewed_at { Faker::Time.between(from: 2.years.ago, to: Date.today) }
    background_reason { UserLifeplan.background_reason.values.sample }
    background_reason_comment { UserLifeplan.background_reason_comment.values.sample }
    legal_heir { UserLifeplan.legal_heir.values.sample }
    legal_heir_comment { UserLifeplan.legal_heir_comment.values.sample }
    residue { UserLifeplan.residue.values.sample }
    relatives { UserLifeplan.relatives.values.sample }
    relatives_comment { UserLifeplan.relatives_comment.values.sample }
    household_disposal { UserLifeplan.household_disposal.values.sample }
    real_estate_disposal { UserLifeplan.real_estate_disposal.values.sample }
    close_grave { UserLifeplan.close_grave.values.sample }
    funeral_memorial_policy { UserLifeplan.funeral_memorial_policy.values.sample }
    small_account { Faker::Bank.account_number(digits: 10) }
    note { Faker::Lorem.paragraph }
    user_id { Faker::Number.number(digits: 5) }
    member_id { Faker::Number.number(digits: 5) }
    contact_note { Faker::Lorem.paragraph }
    contact_inspect_note { Faker::Lorem.paragraph }
    basis_on { Faker::Date.between(from: 2.years.ago, to: Date.today) }
  end
end
