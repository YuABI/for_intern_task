# == Schema Information
#
# Table name: user_lifeplan_remand_histories
#
#  id               :bigint           not null, primary key
#  remanded_at      :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  admin_user_id    :bigint
#  user_lifeplan_id :bigint
#
# Indexes
#
#  index_user_lifeplan_remand_histories_on_admin_user_id     (admin_user_id)
#  index_user_lifeplan_remand_histories_on_user_lifeplan_id  (user_lifeplan_id)
#
require 'rails_helper'

RSpec.describe UserLifeplanRemandHistory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
