class CreateUserLifeplanBeneficiaries < ActiveRecord::Migration[7.1]
  def change
    create_table :user_lifeplan_beneficiaries do |t|
      t.string :name, null: false, default: ''
      t.references :user_lifeplan, null: false, foreign_key: true
      t.integer :deleted, null: false, default: 0
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
