# == Schema Information
#
# Table name: video_channels
#
#  id                       :bigint           not null, primary key
#  URL                      :text
#  deleted                  :integer
#  deleted_at               :datetime
#  explanation              :string
#  title                    :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  video_genre_id           :bigint
#  video_publish_setting_id :integer
#
# Indexes
#
#  index_video_channels_on_video_genre_id  (video_genre_id)
#
# Foreign Keys
#
#  fk_rails_...  (video_genre_id => video_genres.id)
#
require 'rails_helper'

RSpec.describe VideoChannel, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
