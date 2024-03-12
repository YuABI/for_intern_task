class SystemMailer < ApplicationMailer
  def send_sms_login(args)
    subject     = "テスト送信【#{args[:tel]}】"
    @body       = args[:text_body]
    from_sender = SystemConfig.target_record.send_mail_address
    to_email    = SystemConfig.target_record.recv_mail_address
    mail_options = {
      from: safe_from("#{from_sender}"),
      to: safe_to(to_email),
      sender: from_sender,
      subject:,
    }
    mail(mail_options) do |format|
      format.text
    end
  rescue StandardError => e
    LoggerService.new(exception: e, request: nil).call
  end
end
