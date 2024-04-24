# == Schema Information
#
# Table name: addresses
#
#  id                     :integer          not null, primary key
#  address1(番地)         :string           default(""), not null
#  address2(建物名)       :string           default(""), not null
#  address_type(住所区分) :string           default(NULL), not null
#  city(市区町村)         :text             default(""), not null
#  deleted(削除区分)      :integer          default(0), not null
#  deleted_at(削除日時)   :datetime
#  pref(都道府県)         :string           default(""), not null
#  zip(郵便番号)          :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id(顧客)          :bigint           default(0), not null
#
# Indexes
#
#  index_addresses_on_deleted              (deleted)
#  index_addresses_on_user_id              (user_id)
#  index_addresses_on_user_id_and_deleted  (user_id,deleted)
#
class Address < ApplicationRecord
  include AddressSetting
  include ApiWrapperSetting

  belongs_to :user
  delegate :email, to: :user

  enumerize :address_type, in: {
    user: 'user',
    resident_card: 'resident_card',
    domicile: 'domicile',
    other: 'other',
  }, scope: true
  after_initialize :after_initialize_setup

  def after_initialize_setup
    return unless new_record?

    self.address_type = :other if self.address_type.blank?
  end

  class << self
  end
end
