# == Schema Information
#
# Table name: video_publish_settings
#
#  id         :bigint           not null, primary key
#  deleted    :integer
#  deleted_at :datetime
#  setting    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class VideoPublishSetting < ApplicationRecord
    has_many :video_channels
    
    before_create :set_default_values

    private
  
    def set_default_values
      self.deleted ||= 0
    end

end
