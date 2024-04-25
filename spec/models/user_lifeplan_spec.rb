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
#  user_id                   :bigint           not null
#
# Indexes
#
#  index_user_lifeplans_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserLifeplan, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
