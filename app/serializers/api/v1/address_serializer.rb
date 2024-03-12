module Api
  module V1
    class AddressSerializer < ApplicationSerializer
      attributes :user_id, :address_type, :first_name, :family_name, :first_name_kana, :family_name_kana,
                 :zip, :pref, :city, :address1, :address2,
                 :tel
    end
  end
end
