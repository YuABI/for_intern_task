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
require 'rails_helper'

RSpec.describe UserLifeplan, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
