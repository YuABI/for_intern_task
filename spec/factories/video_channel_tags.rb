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
FactoryBot.define do
  factory :video_channel_tag do
    video_channel { nil }
    video_tag { nil }
    deleted { 1 }
    deleted_at { "2024-07-12 15:30:34" }
  end
end
