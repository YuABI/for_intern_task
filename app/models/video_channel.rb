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
  belongs_to :video_genre
  has_and_belongs_to_many :video_tags

  delegate :genre, to: :video_genre, allow_nil: true
  delegate :tag_name, to: :video_tag, allow_nil: true, prefix: true


 include BaseAuthenticatable
  include EmailSetting

  def find_operation(operation_code)
    Operation.find_by(code: operation_code)
  end

  def target_operations(operation_category_id = nil)
    operations = Operation.all
    operations = operations.where(operation_category_id:) if operation_category_id
    operations
  end
  class << self
  end 


end
