class AddNotNullToUserLifeplans < ActiveRecord::Migration[7.1]
  def change
    change_column :user_lifeplans, :contact_note, :text, null: false, default: ""
    change_column :user_lifeplans, :contact_inspect_note, :text, null: false, default: ""
    change_column :user_lifeplan_incomes, :yearly_amount, :integer, null: false, default: 0
    change_column :user_lifeplan_incomes, :payment_start_year, :integer, null: false, default: 0
    change_column :user_lifeplan_incomes, :payment_end_year, :integer, null: false, default: 0
    change_column :user_lifeplan_expenses, :payment_start_year, :integer, null: false, default: 0
    change_column :user_lifeplan_expenses, :payment_end_year, :integer, null: false, default: 0
  end
end
