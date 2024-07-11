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
  belongs_to :video_genre, optional: true
  has_and_belongs_to_many :video_tags, through: :video_channels_video_tags
  has_many_attached :attachment

  before_create :set_default_values

  private

  def set_default_values
    self.deleted ||= 0
  end

  class << self
   def permit_params
     column_names + [
       :video_genre_id,
       :tag_name,
       attachment:[],
     ]
   end
  end



end
