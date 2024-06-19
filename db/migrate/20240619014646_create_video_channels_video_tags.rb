class CreateVideoChannelsVideoTags < ActiveRecord::Migration[7.1]
  def change
    create_table :video_channels_video_tags do |t|
      t.references :video_channel, foreign_key: true
      t.references :video_tag, foreign_key: true

      t.timestamps
    end
  end
end
