# == Schema Information
#
# Table name: video_tags
#
#  id         :bigint           not null, primary key
#  deleted    :integer
#  deleted_at :datetime
#  tag_name   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class VideoTag < ApplicationRecord

    has_many :video_channel_tags
    has_many :video_channels, through: :video_channel_tags

    before_create :set_default_values

    private
  
    def set_default_values
      self.deleted ||= 0
    end

end
