# == Schema Information
#
# Table name: user_lifeplan_expenses
#
#  id                         :bigint           not null, primary key
#  company_name               :string           default(""), not null
#  content                    :string           default(""), not null
#  deleted                    :integer          default(0), not null
#  deleted_at                 :datetime
#  expenditure_item_name      :string           default(""), not null
#  monthly_amount             :integer          default(0), not null
#  name                       :string           default(""), not null
#  note                       :string           default(""), not null
#  pay_by_years               :integer          default(0), not null
#  payment_end_on             :date
#  payment_start_on           :date
#  user_lifeplan_expense_kind :string           default(NULL), not null
#  yearly_amount              :integer          default(0), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  user_lifeplan_id           :bigint           not null
#
# Indexes
#
#  index_user_lifeplan_expenses_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
FactoryBot.define do
  factory :user_lifeplan_expense do

  end
end
