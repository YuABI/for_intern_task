class ChangeMonthlyToYearlyOnIncome < ActiveRecord::Migration[7.1]
  def change
    add_column :user_lifeplan_incomes, :yearly_amount, :integer
  end
end
