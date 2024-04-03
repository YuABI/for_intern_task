class CreateUserLifeplans < ActiveRecord::Migration[7.1]
  def change
    create_table :user_lifeplans do |t|
      t.string :name, null: false, default: ''
      t.integer :status, null: false, default: 0
      # TODO: まだUserができていないので、一旦コメントアウト
      # t.references :user, null: false, foreign_key: true
      t.datetime :apply_reviewed_at
      t.datetime :reviewed_at
      t.integer :background_reason, null: false, default: 0
      t.string :background_reason_comment, null: false, default: ''
      t.integer :legal_heir, null: false, default: 0
      t.string :legal_heir_comment, null: false, default: ''
      t.integer :residue, null: false, default: 0
      t.integer :relatives, null: false, default: 0
      t.string :relatives_comment, null: false, default: ''
      t.integer :household_disposal, null: false, default: 0
      t.integer :real_estate_disposal, null: false, default: 0
      t.integer :close_grave, null: false, default: 0
      t.integer :funeral_memorial_policy, null: false, default: 0
      t.string :small_account, null: false, default: ''
      t.string :note, null: false, default: ''
      t.integer :deleted, null: false, default: 0
      t.datetime :deleted_at

      t.timestamps

      t.timestamps
    end
  end
end
