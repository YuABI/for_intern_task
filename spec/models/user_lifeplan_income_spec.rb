# == Schema Information
#
# Table name: user_lifeplan_incomes
#
#  id                :bigint           not null, primary key
#  asset_income_kind :integer          default(0), not null
#  assets_number     :integer          default(0), not null
#  company_name      :string           default(""), not null
#  content           :string           default(""), not null
#  deleted           :integer          default(0), not null
#  deleted_at        :datetime
#  income_kind       :integer          default(0), not null
#  monthly_amount    :integer          default(0), not null
#  name              :string           default(""), not null
#  payment_end_at    :datetime
#  payment_start_at  :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_lifeplan_id  :bigint           not null
#
# Indexes
#
#  index_user_lifeplan_incomes_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
require 'rails_helper'

RSpec.describe UserLifeplanIncome, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
