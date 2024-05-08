class ChangeStatusToStatusIsToFinanceCondition < ActiveRecord::Migration[7.1]
  def change
    rename_column :user_lifeplan_finance_conditions, :status, :user_lifeplan_finance_condition_status_id
  end
end
