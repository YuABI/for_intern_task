# == Schema Information
#
# Table name: video_genres
#
#  id                   :bigint           not null, primary key
#  deleted(削除区分)    :integer          default(0), not null
#  deleted_at(削除日時) :datetime
#  name(ジャンル名)     :string           default(""), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class VideoGenre < ApplicationRecord
end
