class ChangeDatetimeToDateOnUserLifeplanModels < ActiveRecord::Migration[7.1]
  def change
    change_column :user_lifeplan_assets, :reference_at, :date, null: true
    change_column :user_lifeplan_expenses, :payment_start_at, :date, null: true
    change_column :user_lifeplan_expenses, :payment_end_at, :date, null: true

    change_column :user_lifeplan_finance_conditions, :until_submitted_on, :date, null: true

    change_column :user_lifeplan_incomes, :payment_start_at, :date, null: true
    change_column :user_lifeplan_incomes, :payment_end_at, :date, null: true

    rename_column :user_lifeplan_assets, :reference_at, :reference_on
    rename_column :user_lifeplan_expenses, :payment_start_at, :payment_start_on
    rename_column :user_lifeplan_expenses, :payment_end_at, :payment_end_on
    rename_column :user_lifeplan_incomes, :payment_start_at, :payment_start_on
    rename_column :user_lifeplan_incomes, :payment_end_at, :payment_end_on
  end
end
