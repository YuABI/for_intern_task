class CheckoutMailer < AutoReplyMailer
  def send_thank_you_order(args)
    subject = eval(args[:mobile] ? 'args[:header].mail_subject_mobile' : 'args[:header].mail_subject')
    subject = "【#{args[:from_sender]}】ご注文ありがとうございました。" if subject.blank?
    header_message = eval(args[:mobile] ? 'args[:header].message_mobile' : 'args[:header].message')
    footer_message = eval(args[:mobile] ? 'args[:footer].message_mobile' : 'args[:footer].message')
    # 他のメールでも@@order_result@@は利用されるので、整形時に改めて抽出・置換する
    @body = args[:header].decorate.thank_you_order([header_message, '@@order_result@@', footer_message].join("\n"),
                                                   args)

    mail_options = {
      from: safe_from("#{args[:from_sender]} <#{args[:from_email]}>"),
      to: safe_to(args[:to_email]),
      sender: "#{args[:from_sender]} <#{args[:from_email]}>",
      subject:,
      bcc: args[:bcc],
    }
    mail(mail_options) do |format|
      format.text
    end
  rescue StandardError => e
    LoggerService.new(exception: e, request: nil).call
  end

  def send_create_user(args)
    subject = eval(args[:mobile] ? 'args[:body].mail_subject_mobile' : 'args[:body].mail_subject')
    subject = "【#{args[:from_sender]}】会員登録を承りました。" if subject.blank?
    message = eval(args[:mobile] ? 'args[:body].message_mobile' : 'args[:body].message')
    @body = args[:body].decorate.create_user(message, args)
    mail_options = {
      from: safe_from("#{args[:from_sender]} <#{args[:from_email]}>"),
      to: safe_to(args[:to_email]),
      sender: "#{args[:from_sender]} <#{args[:from_email]}>",
      subject:,
      bcc: args[:bcc],
    }
    mail(mail_options) do |format|
      format.text
    end
  rescue StandardError => e
    LoggerService.new(exception: e, request: nil).call
  end

  def send_forget_password(args)
    subject = eval(args[:mobile] ? 'args[:body].mail_subject_mobile' : 'args[:body].mail_subject')
    subject = "【#{args[:from_sender]}】パスワード再発行のご案内" if subject.blank?
    message = eval(args[:mobile] ? 'args[:body].message_mobile' : 'args[:body].message')
    @body = args[:body].decorate.forget_password(message, args)
    mail_options = {
      from: safe_from("#{args[:from_sender]} <#{args[:from_email]}>"),
      to: safe_to(args[:to_email]),
      sender: "#{args[:from_sender]} <#{args[:from_email]}>",
      subject:,
      bcc: args[:bcc],
    }
    mail(mail_options) do |format|
      format.text
    end
  rescue StandardError => e
    LoggerService.new(exception: e, request: nil).call
  end
end
