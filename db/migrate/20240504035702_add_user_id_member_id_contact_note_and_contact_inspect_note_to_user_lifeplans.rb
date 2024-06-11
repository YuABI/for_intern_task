class AddUserIdMemberIdContactNoteAndContactInspectNoteToUserLifeplans < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_lifeplans, :member, null: false, index: true
    add_column :user_lifeplans, :contact_note, :text
    add_column :user_lifeplans, :contact_inspect_note, :text
  end
end
