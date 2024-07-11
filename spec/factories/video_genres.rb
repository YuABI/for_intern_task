# == Schema Information
#
# Table name: video_genres
#
#  id         :bigint           not null, primary key
#  deleted    :integer
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :video_genre do
    name { "MyString" }
    deleted { 1 }
    deleted_at { "2024-06-21 14:09:13" }
  end
end
