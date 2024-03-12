module Api
  module V1
    class UserSerializer < ApplicationSerializer
      include Api::V1::DeletedSerializerable
      attributes :email, :sex, :birthday, :last_logined_at

      has_many :addresses
      has_many :user_inquiries
    end
  end
end
