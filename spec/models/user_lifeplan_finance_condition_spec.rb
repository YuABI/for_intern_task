# == Schema Information
#
# Table name: user_lifeplan_finance_conditions
#
#  id                                        :bigint           not null, primary key
#  account                                   :string           default(""), not null
#  account_info                              :string           default(""), not null
#  balance                                   :integer          default(0), not null
#  confirmed_on                              :date
#  content                                   :string           default(""), not null
#  deleted                                   :integer          default(0), not null
#  deleted_at                                :datetime
#  finance_condition_kind                    :string           default(NULL), not null
#  until_submitted_on                        :date
#  created_at                                :datetime         not null
#  updated_at                                :datetime         not null
#  user_lifeplan_finance_condition_status_id :integer          default(1), not null
#  user_lifeplan_id                          :bigint           not null
#
# Indexes
#
#  index_user_lifeplan_finance_conditions_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
require 'rails_helper'

RSpec.describe UserLifeplanFinanceCondition, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
