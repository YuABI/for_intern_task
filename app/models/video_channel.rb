# == Schema Information
#
# Table name: video_channels
#
#  id             :bigint           not null, primary key
#  URL            :text
#  deleted        :integer
#  deleted_at     :datetime
#  explanation    :string
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  video_genre_id :bigint
#
# Indexes
#
#  index_video_channels_on_video_genre_id  (video_genre_id)
#
# Foreign Keys
#
#  fk_rails_...  (video_genre_id => video_genres.id)
#
class VideoChannel < ApplicationRecord
  belongs_to :genre
end
