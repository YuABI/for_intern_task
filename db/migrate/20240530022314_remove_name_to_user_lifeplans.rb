class RemoveNameToUserLifeplans < ActiveRecord::Migration[7.1]
  def change
    remove_column :user_lifeplans, :name, :string
  end
end
