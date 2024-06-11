# == Schema Information
#
# Table name: organizations
#
#  id                                     :bigint           not null, primary key
#  address1(番地)                         :string
#  address2(建物名)                       :string
#  city(市区町村)                         :text
#  deleted(削除区分)                      :integer          default(0), not null
#  deleted_at(削除日時)                   :datetime
#  fax(FAX番号)                           :string
#  invoice_number(インボイス登録番号)     :string
#  name(名称)                             :string           default(""), not null
#  payment_term_to_user(顧客宛支払い条件) :text
#  pref(都道府県)                         :string
#  tel(電話番号)                          :string
#  zip(郵便番号)                          :string
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#
# Indexes
#
#  index_organizations_on_deleted           (deleted)
#  index_organizations_on_name              (name)
#  index_organizations_on_name_and_deleted  (name,deleted)
#
class Organization < ApplicationRecord

  has_many :members

  class << self
  end
end
