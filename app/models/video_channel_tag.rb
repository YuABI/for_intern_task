# == Schema Information
#
# Table name: video_channel_tags
#
#  id               :bigint           not null, primary key
#  deleted          :integer
#  deleted_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  video_channel_id :bigint
#  video_tag_id     :bigint
#
# Indexes
#
#  index_video_channel_tags_on_video_channel_id  (video_channel_id)
#  index_video_channel_tags_on_video_tag_id      (video_tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (video_channel_id => video_channels.id)
#  fk_rails_...  (video_tag_id => video_tags.id)
#
class VideoChannelTag < ApplicationRecord
  belongs_to :video_channel
  belongs_to :video_tag
end
