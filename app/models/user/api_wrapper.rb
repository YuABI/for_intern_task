# == Schema Information
#
# Table name: users
#
#  id                                  :bigint           not null, primary key
#  birthday(誕生日)                    :date
#  deleted(削除区分)                   :integer          default(0), not null
#  deleted_at(削除日時)                :datetime
#  email(メールアドレス)               :string           default(""), not null
#  hashed_password(ハッシュパスワード) :string           default(""), not null
#  last_logined_at(最終ログイン日時)   :datetime
#  name(氏名)                          :string           default(""), not null
#  salt                                :string
#  sex                                 :integer          default("unknown"), not null
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
  class ApiWrapper < ActiveType::Record[User]
    attribute :default_address_attributes, :hash
    attribute :address_attributes, :array

    def api_after_initialize_setup
      if new_record?
        user_address_setup
      end
      if default_address_attributes.present?
        self.user_address.attributes = default_address_attributes
      end
    end

    def set_association(options = {})
      options.merge(address_type: :other)
    end

    class << self
      def permit_params
        [
          :email, # メールアドレス
          :password, # パスワード
          :password_confirmation, # パスワード確認
          :sex, # 性別
          :birthday, # 生年月日
          :deleted,  # 会員登録
          { default_address_attributes: Address::ApiWrapper.permit_params },
        ]
      end

      def create_addresses_permit_params
        [
          address_attributes: Address::ApiWrapper.permit_params,
        ]
      end

      def update_addresses_permit_params
        [
          address_attributes: Address::ApiWrapper.permit_params + [:id],
        ]
      end
    end
  end
end
