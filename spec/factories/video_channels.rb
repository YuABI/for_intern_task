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
FactoryBot.define do
  factory :video_channel do
    URL { "MyText" }
    title { "MyString" }
    explanation { "MyString" }
    genre { nil }
    deleted { 1 }
    deleted_at { "2024-06-12 14:37:49" }
  end
end
