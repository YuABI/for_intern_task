class CreateVideoChannelsVideoTags < ActiveRecord::Migration[7.1]
  def change
    create_table :video_channels_video_tags do |t|
      t.references :video_channel, foreign_key: true
      t.references :video_tag, foreign_key: true

      t.timestamps
    end
    add_index :video_channels_video_tags, [:video_channel_id, :video_tag_id], unique: true, name:index_video_channels_video_tags_on_channel_and_tag
  end
end
