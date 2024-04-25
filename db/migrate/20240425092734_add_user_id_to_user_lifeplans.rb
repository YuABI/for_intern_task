class AddUserIdToUserLifeplans < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_lifeplans, :user, null: false, foreign_key: true
  end
end
