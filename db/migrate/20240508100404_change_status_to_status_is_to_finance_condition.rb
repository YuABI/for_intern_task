class ChangeStatusToStatusIsToFinanceCondition < ActiveRecord::Migration[7.1]
  def change
    rename_column :user_lifeplan_finance_conditions, :status, :user_lifeplan_finance_condition_status_id
    change_column :user_lifeplan_finance_conditions, :user_lifeplan_finance_condition_status_id, :integer, default: 1, null: false
  end
end
