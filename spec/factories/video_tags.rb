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
FactoryBot.define do
  factory :video_tag do
    tag_name { "MyString" }
    deleted { 1 }
    deleted_at { "2024-06-21 14:09:26" }
  end
end
