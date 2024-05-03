class AddDocAndConfirmedAtToFinanceConditions < ActiveRecord::Migration[7.1]
  def change
    add_column :user_lifeplan_finance_conditions, :confirmed_on, :date
    rename_column :user_lifeplan_finance_conditions, :until_submitted_at, :until_submitted_on
  end
end
