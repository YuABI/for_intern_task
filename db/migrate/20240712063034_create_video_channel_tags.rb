class CreateVideoChannelTags < ActiveRecord::Migration[7.1]
  def change
    create_table :video_channel_tags do |t|
      t.references :video_channel, foreign_key: true
      t.references :video_tag, foreign_key: true
      t.integer :deleted
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
