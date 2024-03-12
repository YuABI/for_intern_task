module MailSender
  class BaseService < BaseService
    attr_reader :target_config, :message_code

    def initialize(**args)
      @target_config   = args[:target_config] || SystemConfig.target_record
      @message_code    = args[:message_code]
      @message_object  = Message.send(@message_code)
    end

    def call
      yield if block_given?
    end
  end
end
