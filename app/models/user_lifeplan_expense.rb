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
#  payment_end_year           :integer
#  payment_start_year         :integer
#  spending_item              :string           default(NULL), not null
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
class UserLifeplanExpense < ApplicationRecord
  belongs_to :user_lifeplan
  attribute :payment_start_year, default: -> { Time.current.year }
  attribute :payment_end_year, default: -> { Time.current.year }
  attribute :pay_by_years, default: -> { 1 }

  enumerize :user_lifeplan_expense_kind, in: %i[
    spending life_event elderly_facility end_of_life deposit
  ], scope: true, predicates: true

  enumerize :spending_item, in: %i[
    unselected total_living_costs living_costs_housing_food food_expenses rent
    maintenance_fee parking_fee total_utilities electricity gas water total_communication_costs communication_costs
    broadcasting_fee newspaper_fee neighborhood_association_fee medical_expenses taxes insurance_premiums
    miscellaneous_expenses
  ], default: :unselected

  class << self
    def permit_params
      super
    end
  end
end
