# == Schema Information
#
# Table name: video_tags
#
#  id                   :bigint           not null, primary key
#  deleted(削除区分)    :integer          default(0), not null
#  deleted_at(削除日時) :datetime
#  tag_name(タグ名)     :string           default(""), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class VideoTag < ApplicationRecord
    has_and_belongs_to_many :video_channels, join_table: 'video_channels_video_tags'
end
