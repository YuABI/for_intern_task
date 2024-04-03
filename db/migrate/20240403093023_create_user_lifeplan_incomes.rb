class CreateUserLifeplanIncomes < ActiveRecord::Migration[7.1]
  def change
    create_table :user_lifeplan_incomes do |t|
      t.string :name, null: false, default: ''
      t.references :user_lifeplan, null: false, foreign_key: true
      t.integer :income_kind, null: false, default: 0
      t.integer :asset_income_kind, null: false, default: 0
      t.string :content, null: false, default: ''
      t.string :company_name, null: false, default: ''
      t.integer :assets_number, null: false, default: 0
      t.datetime :payment_start_at
      t.datetime :payment_end_at
      t.integer :monthly_amount, null: false, default: 0
      t.integer :deleted, null: false, default: 0
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
