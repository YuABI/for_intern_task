class RemoveNameToContact < ActiveRecord::Migration[7.1]
  def change
    remove_column :user_lifeplan_contacts, :name, :string
  end
end
