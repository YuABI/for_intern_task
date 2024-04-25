# == Schema Information
#
# Table name: users
#
#  id                                  :bigint           not null, primary key
#  birthday(誕生日)                    :date
#  company_name(会社名)                :string           default(""), not null
#  deleted(削除区分)                   :integer          default(0), not null
#  deleted_at(削除日時)                :datetime
#  division_name(部署名)               :string           default(""), not null
#  email(メールアドレス)               :string           default(""), not null
#  family_name(姓)                     :string           default(""), not null
#  family_name_kana(姓カナ)            :string           default(""), not null
#  first_name(名)                      :string           default(""), not null
#  first_name_kana(名カナ)             :string           default(""), not null
#  hashed_password(ハッシュパスワード) :string           default(""), not null
#  last_logined_at(最終ログイン日時)   :datetime
#  modile_tel(携帯番号)                :string           default(""), not null
#  position_name(役職名)               :string           default(""), not null
#  salt                                :string
#  sex                                 :integer          default("unknown"), not null
#  tel(電話番号)                       :string           default(""), not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#
# Indexes
#
#  index_users_on_deleted            (deleted)
#  index_users_on_email              (email)
#  index_users_on_email_and_deleted  (email,deleted)
#
class User < ApplicationRecord
  # include BaseAuthenticatable TODO: 顧客画面実装時に構築
  include EmailSetting
  include MemberSetting

  validates :family_name,       presence: { if: proc { |a| a.family_name      != '　' } }
  validates :first_name,        presence: { if: proc { |a| a.first_name       != '　' } }
  validates :family_name_kana, presence: {}
  validates :first_name_kana, presence: {}
  validates :family_name_kana, format: { with: Regex::KANA }
  validates :first_name_kana, format: { with: Regex::KANA }

  has_many :addresses, -> { order(address_type: :desc, id: :asc) }
  has_many :user_inquiries, -> { order(inquiry_at: :desc) }
  has_many :user_counsels, -> { order(id: :desc) }
  has_many :user_lifeplans, -> { order(id: :desc) }

  has_many :other_addresses, -> { where(address_type: :other) }, class_name: 'Address'

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :user_inquiries, allow_destroy: true
  accepts_nested_attributes_for :user_counsels, allow_destroy: true

  enumerize :sex, in: {
    unknown: 0,
    male: 1,
    female: 2,
  }, scope: true

  validates :birthday, comparison: { less_than: Date.today }, if: -> { use_birthday? }
  after_initialize :after_initialize_setup

  def after_initialize_setup
    nil unless new_record?
  end

  def user_address_setup
    addresses.build(address_type: :user)
  end

  def user_address
    # 登録前でも使いたいからDB参照しない
    addresses.inject(nil) do |_r, a|
      r = a if a.address_type.user?
    end
  end

  def sort_addresses
    addresses.sort_by { |i| [i.address_type] }
  end

  def sort_user_inquiries
    user_inquiries.sort_by { |i| [i.inquiry_at] }
  end

  def use_birthday?
    set_target_config
    birthday.present?
  end

  class << self
    def permit_params
      super + [
        addresses_attributes: Address.permit_params,
        user_inquiries_attributes: UserInquiry.permit_params,
      ]
    end
  end
end
