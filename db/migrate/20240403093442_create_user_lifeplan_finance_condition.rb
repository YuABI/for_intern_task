class CreateUserLifeplanFinanceCondition < ActiveRecord::Migration[7.1]
  def change
    create_table :user_lifeplan_finance_conditions do |t|
      t.references :user_lifeplan, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.datetime :until_submitted_at, null: false
      t.string :account, null: false, default: ''
      t.string :account_info, null: false, default: ''
      t.integer :balance, null: false, default: 0
      t.integer :deleted, null: false, default: 0
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
