module Api
  module V1
    class UserInquirySerializer < ApplicationSerializer
      attributes :user_id, :admin_user_id, :inquiry_at, :content
    end
  end
end
