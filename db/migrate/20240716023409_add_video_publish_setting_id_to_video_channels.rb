class AddVideoPublishSettingIdToVideoChannels < ActiveRecord::Migration[7.1]
  def change
    add_column :video_channels, :video_publish_setting_id, :integer
    add_foreign_key :video_channels, :video_publish_settings
  end
end
