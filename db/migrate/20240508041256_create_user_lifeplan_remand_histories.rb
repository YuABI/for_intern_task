class CreateUserLifeplanRemandHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :user_lifeplan_remand_histories do |t|
      t.references :user_lifeplan
      t.references :admin_user
      t.datetime :remanded_at
      t.timestamps
    end
  end
end
