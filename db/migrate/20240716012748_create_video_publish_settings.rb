class CreateVideoPublishSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :video_publish_settings do |t|
      t.string :setting
      t.integer :deleted
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
