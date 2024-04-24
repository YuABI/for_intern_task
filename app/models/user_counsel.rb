# == Schema Information
#
# Table name: user_counsels
#
#  id                                :bigint           not null, primary key
#  counseling_at(カウンセリング日付) :datetime
#  deleted(削除区分)                 :integer          default(0), not null
#  deleted_at(削除日時)              :datetime
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  member_id(メンバー)               :bigint           default(0), not null
#  user_id(顧客)                     :bigint           default(0), not null
#
class UserCounsel < ApplicationRecord
  belongs_to :user


  enumerize :counseling_category, in: {
    whole: 0,
    trigger: 1,
    personality: 2,
    real_estate: 3,
    financial: 4,
    income: 5,
    expense: 6,
    facility: 7,
    medical_care: 8,
    after_death: 9,
  }, scope: true

  class << self
  end
end
