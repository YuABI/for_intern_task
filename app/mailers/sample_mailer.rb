class SampleMailer < ApplicationMailer
  def send_test(subject)
    to_email             = 'harato@asnica.co.jp'
    from_email           = 'harato@asnica.co.jp'
    from_sender          = 'テモナ株式会社'

    mail_options = {
      from: safe_from("#{from_sender} <#{from_email}>"),
      to: safe_to(to_email),
      sender: "#{from_sender} <#{from_email}>",
      subject:,
    }
    mail(mail_options) do |format|
      format.html
      format.text
    end
  end
end
