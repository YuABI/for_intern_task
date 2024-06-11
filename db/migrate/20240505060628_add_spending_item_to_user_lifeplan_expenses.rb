class AddSpendingItemToUserLifeplanExpenses < ActiveRecord::Migration[7.1]
  def change
    add_column :user_lifeplan_expenses, :spending_item, :string, null: false, default: ''
  end
end
