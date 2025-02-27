# == Schema Information
#
# Table name: user_inquiries
#
#  id                         :integer          not null, primary key
#  content(内容)              :string           default(""), not null
#  deleted(削除区分)          :integer          default(0), not null
#  deleted_at(削除日時)       :datetime
#  inquiry_at(問い合わせ日時) :datetime
#  mode(区分)                 :integer          default(0), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  member_id(会員)            :string           default(""), not null
#  user_id(顧客)              :bigint           default(0), not null
#
# Indexes
#
#  index_user_inquiries_on_deleted              (deleted)
#  index_user_inquiries_on_member_id            (member_id)
#  index_user_inquiries_on_user_id              (user_id)
#  index_user_inquiries_on_user_id_and_deleted  (user_id,deleted)
#
class UserInquiry < ApplicationRecord
  belongs_to :user
  belongs_to :admin_user

  class << self
  end
end
