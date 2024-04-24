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
  class ApiWrapper < ActiveType::Record[Address]
    class << self
      def permit_params
        [
          :first_name, # お名前(姓)
          :family_name, # お名前(名)
          :first_name_kana, # お名前(メイ）
          :family_name_kana, # お名前(セイ)
          :zip, # 郵便番号
          :pref,  # 都道府県
          :city,  # 市郡区・町・村
          :address1,  # 丁目・番地
          :address2,  # 建物名
          :tel,  # 電話番号
        ]
      end
    end
  end
end
