# == Schema Information
#
# Table name: user_lifeplan_contacts
#
#  id               :bigint           not null, primary key
#  contact_kind     :integer          default(0), not null
#  deleted          :integer          default(0), not null
#  deleted_at       :datetime
#  name             :string           default(""), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_lifeplan_id :bigint           not null
#
# Indexes
#
#  index_user_lifeplan_contacts_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
require 'rails_helper'

RSpec.describe UserLifeplanContact, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
