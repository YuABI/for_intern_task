# == Schema Information
#
# Table name: members
#
#  id                                  :bigint           not null, primary key
#  available(利用区分)                 :integer          default(1), not null
#  deleted(削除区分)                   :integer          default(0), not null
#  deleted_at(削除日時)                :datetime
#  email(メールアドレス)               :string           default(""), not null
#  family_name(姓)                     :string           default(""), not null
#  family_name_kana(姓カナ)            :string           default(""), not null
#  first_name(名)                      :string           default(""), not null
#  first_name_kana(名カナ)             :string           default(""), not null
#  hashed_password(ハッシュパスワード) :string           default(""), not null
#  last_logined_at(最終ログイン日時)   :datetime
#  mobile_tel(携帯番号)                :string           default(""), not null
#  salt                                :string
#  tel(電話番号)                       :string           default(""), not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  organization_id(組織)               :bigint           default(0), not null
#
# Indexes
#
#  index_members_on_deleted            (deleted)
#  index_members_on_email              (email)
#  index_members_on_email_and_deleted  (email,deleted)
#
class Member < ApplicationRecord
  include BaseAuthenticatable
  include EmailSetting

  belongs_to :organization

  class << self
  end
end
