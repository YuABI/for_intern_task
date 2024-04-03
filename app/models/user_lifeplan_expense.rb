# == Schema Information
#
# Table name: user_lifeplan_expenses
#
#  id                    :bigint           not null, primary key
#  assets_number         :integer          default(0), not null
#  company_name          :string           default(""), not null
#  content               :integer          default(0), not null
#  deleted               :integer          default(0), not null
#  deleted_at            :datetime
#  expenditure_item_name :integer          default(0), not null
#  monthly_amount        :integer          default(0), not null
#  name                  :string           default(""), not null
#  note                  :integer          default(0), not null
#  pay_by_years          :integer          default(0), not null
#  payment_end_at        :datetime         not null
#  payment_start_at      :datetime         not null
#  yearly_amount         :integer          default(0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_lifeplan_id      :bigint           not null
#
# Indexes
#
#  index_user_lifeplan_expenses_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
class UserLifeplanExpense < ApplicationRecord
  belongs_to :user_lifeplan
end
