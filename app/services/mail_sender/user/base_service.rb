module MailSender
  module User
    class BaseService < MailSender::BaseService
      attr_reader :user, :only_alive

      def initialize(**args)
        super(**args)
        @user       = args[:user]
        @only_alive = args[:only_alive]
      end

      def call
        return true if @only_alive && !@user._alive_?

        super do
          yield if block_given?
        end
      end
    end
  end
end
