# == Schema Information
#
# Table name: user_lifeplan_finance_conditions
#
#  id                 :bigint           not null, primary key
#  account            :string           default(""), not null
#  account_info       :string           default(""), not null
#  balance            :integer          default(0), not null
#  deleted            :integer          default(0), not null
#  deleted_at         :datetime
#  status             :integer          default(0), not null
#  until_submitted_at :datetime         not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_lifeplan_id   :bigint           not null
#
# Indexes
#
#  index_user_lifeplan_finance_conditions_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
class UserLifeplanFinanceCondition < ApplicationRecord
  belongs_to :user_lifeplan
end
