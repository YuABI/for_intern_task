class ChangeDateToYearIncomAndExpense < ActiveRecord::Migration[7.1]
  def change
    add_column :user_lifeplan_incomes, :payment_start_year, :integer, limit: 4
    remove_column :user_lifeplan_incomes, :payment_start_on, :date

    add_column :user_lifeplan_incomes, :payment_end_year, :integer, limit: 4
    remove_column :user_lifeplan_incomes, :payment_end_on, :date

    add_column :user_lifeplan_expenses, :payment_start_year, :integer, limit: 4
    remove_column :user_lifeplan_expenses, :payment_start_on, :date

    add_column :user_lifeplan_expenses, :payment_end_year, :integer, limit: 4
    remove_column :user_lifeplan_expenses, :payment_end_on, :date
  end
end
