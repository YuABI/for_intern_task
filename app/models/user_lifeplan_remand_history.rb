# == Schema Information
#
# Table name: user_lifeplan_remand_histories
#
#  id               :bigint           not null, primary key
#  remand_at        :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_lifeplan_id :bigint
#
# Indexes
#
#  index_user_lifeplan_remand_histories_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
class UserLifeplanRemandHistory < ApplicationRecord
  belongs_to :user_lifeplan, optional: true
end
