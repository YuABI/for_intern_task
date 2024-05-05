# == Schema Information
#
# Table name: user_lifeplan_incomes
#
#  id                        :bigint           not null, primary key
#  cache_income_kind         :string           default(NULL), not null
#  company_name              :string           default(""), not null
#  content                   :string           default(""), not null
#  deleted                   :integer          default(0), not null
#  deleted_at                :datetime
#  monthly_amount            :integer          default(0), not null
#  name                      :string           default(""), not null
#  payment_end_on            :date
#  payment_start_on          :date
#  pension_kind              :string           default(NULL), not null
#  user_lifeplan_income_kind :string           default(NULL), not null
#  yearly_amount             :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  user_lifeplan_id          :bigint           not null
#
# Indexes
#
#  index_user_lifeplan_incomes_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
class UserLifeplanIncome < ApplicationRecord
  belongs_to :user_lifeplan

  enumerize :user_lifeplan_income_kind, in: %i[
    pension cache_income temporary_cache_income
  ]
  enumerize :pension_kind, in: %i[
    national_pension welfare_pension national_welfare_pension survivor_pension corporate_pension disability_pension
    private_pension_insurance pension_trust unselected
  ], default: :unselected
  enumerize :cache_income_kind, in: %i[
    salary severance_pay investment_fund insurance_money trust_fund donation rental_income parking_income refund
    other_income unselected
  ], default: :unselected


  class << self
    def permit_params
      super
    end
  end
end
