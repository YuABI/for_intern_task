module MailSender
  module User
    class SendCreateUserService < MailSender::User::BaseService
      def initialize(**args)
        args[:message_code] = :create_user_record
        args[:only_alive]   = true
        super(**args)
      end

      def call
        super do
          CheckoutMailer.safe_deliver(
            :send_create_user,
            { body: @message_object, user: @user, shipping_address: @user.user_shipping_address }
          )
        end
        true
      end
    end
  end
end
