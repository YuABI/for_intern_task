class CreateUserLifeplanAssets < ActiveRecord::Migration[7.1]
  def change
    create_table :user_lifeplan_assets do |t|
      t.string :name, null: false, default: ''
      t.references :user_lifeplan, null: false, foreign_key: true
      t.integer :rate, null: false, default: 0
      t.integer :asset_kind, null: false, default: 0
      t.string :financial_institution_name, null: false, default: ''
      t.string :store_name, null: false, default: ''
      t.integer :deposit_kind, null: false, default: 0
      t.string :account_number, null: false, default: ''
      t.datetime :reference_at
      t.integer :amount_of_money, null: false, default: 0
      t.string :content, null: false, default: ''
      t.string :company_name, null: false, default: ''
      t.integer :asset_number, null: false, default: 0
      t.integer :asset_appraisal_value, null: false, default: 0
      t.integer :equity_appraisal_value, null: false, default: 0
      t.integer :scheduled_for_sale, null: false, default: 0
      t.integer :sundry_expenses, null: false, default: 0
      t.integer :profit, null: false, default: 0
      t.string :description, null: false, default: ''
      t.integer :deleted, null: false, default: 0
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
