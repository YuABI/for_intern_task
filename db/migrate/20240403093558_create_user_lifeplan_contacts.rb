class CreateUserLifeplanContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :user_lifeplan_contacts do |t|
      t.references :user_lifeplan, null: false, foreign_key: true
      t.string :name, null: false, default: ''
      t.integer :contact_kind, null: false, default: 0
      t.integer :deleted, null: false, default: 0
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
