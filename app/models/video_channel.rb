# == Schema Information
#
# Table name: video_channels
#
#  id                    :bigint           not null, primary key
#  URL(URL)              :text             default(""), not null
#  deleted(削除区分)     :integer          default(0), not null
#  deleted_at(削除日時)  :datetime
#  explanation(詳細説明) :string           default(""), not null
#  title(タイトル)       :string           default(""), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  video_genre_id        :bigint
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
  has_and_belongs_to_many :video_tags, join_table: 'video_channels_video_tags'

  # validates :video_genre_id, presence: true, inclusion: { in: VideoGenre.pluck(:id) }


  def find_operation(operation_code)
    Operation.find_by(code: operation_code)
  end

  def target_operations(operation_category_id = nil)
    operations = Operation.all
    operations = operations.where(operation_category_id:) if operation_category_id
    operations
  end

  # ビデオチャンネルに関連付けられているすべてのビデオタグの名前を配列として返すメソッド
  def tag_names
    video_tags.pluck(:tag_name)
  end
end