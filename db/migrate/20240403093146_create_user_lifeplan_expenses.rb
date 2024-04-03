class CreateUserLifeplanExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :user_lifeplan_expenses do |t|
      t.string :name, null: false, default: ''
      t.integer :expenditure_item_name, null: false, default: 0
      t.references :user_lifeplan, null: false, foreign_key: true
      t.integer :content, null: false, default: 0
      t.string :company_name, null: false, default: ''
      t.integer :assets_number, null: false, default: 0
      t.integer :note, null: false, default: 0
      t.datetime :payment_start_at, null: false
      t.datetime :payment_end_at, null: false
      t.integer :monthly_amount, null: false, default: 0
      t.integer :pay_by_years, null: false, default: 0
      t.integer :yearly_amount, null: false, default: 0
      t.integer :deleted, null: false, default: 0
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
