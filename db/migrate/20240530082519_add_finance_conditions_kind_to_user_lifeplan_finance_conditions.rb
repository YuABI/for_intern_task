class AddFinanceConditionsKindToUserLifeplanFinanceConditions < ActiveRecord::Migration[7.1]
  def change
    add_column :user_lifeplan_finance_conditions, :finance_condition_kind, :string, null: false, default: ''
    add_column :user_lifeplan_finance_conditions, :content, :string, null: false, default: ''
  end
end
