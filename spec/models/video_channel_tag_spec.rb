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
require 'rails_helper'

RSpec.describe VideoChannelTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
