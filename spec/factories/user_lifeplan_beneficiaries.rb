# == Schema Information
#
# Table name: user_lifeplan_beneficiaries
#
#  id               :bigint           not null, primary key
#  deleted          :integer          default(0), not null
#  deleted_at       :datetime
#  name             :string           default(""), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_lifeplan_id :bigint           not null
#
# Indexes
#
#  index_user_lifeplan_beneficiaries_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
FactoryBot.define do
  factory :user_lifeplan_beneficiary do

  end
end
