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
FactoryBot.define do
  factory :video_publish_setting do
    setting { "MyString" }
    deleted { 1 }
    deleted_at { "2024-07-16 10:27:48" }
  end
end
