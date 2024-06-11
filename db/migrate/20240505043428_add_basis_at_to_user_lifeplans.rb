class AddBasisAtToUserLifeplans < ActiveRecord::Migration[7.1]
  def change
    add_column :user_lifeplans, :basis_on, :date
  end
end
