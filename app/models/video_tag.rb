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
    has_and_belongs_to_many :video_channels
end
