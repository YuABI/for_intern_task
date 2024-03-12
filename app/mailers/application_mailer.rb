class ApplicationMailer < ActionMailer::Base
  layout 'mailer'
  default header: { 'X-Mailer': 'egg_repeat_soul' }
  default sent_on: Time.now

  # メール送信+ログ記録
  # 例外が発生したらログを吐いて握りつぶしちゃう
  #
  # === Args
  # _method_ :: 配信するメール名
  # _args_ :: 配信メソッドに渡す引数
  # _log_ :: result
  #
  # === Example
  # AccountMailer.safe_deliver(:thanks_for_your_signup, user, log: "user_id: #{user.id}")
  def self.safe_deliver(method, args, log: {})
    logs = []
    logs << '======================================================='
    message = "#{self}##{method}"
    no_err = true
    begin
      response = send(method, args).deliver
      msg = "Successfully sent email #{message}"
      logs << msg
    rescue Timeout::Error => e # Timeout::ErrorはStandardErrorのサブクラスではないので捕捉されない為、別途記述
      logs << "Timeout to deliver mail #{message} #{e}"
      no_err = false
    rescue StandardError => e
      logs << "Failed to deliver mail #{message} #{e}"
      no_err = false
    ensure
      logs << '-- time --'
      logs << "  #{Time.now}"
      if log
        logs << '-- log --'
        log.keys.each { |key| logs << "#{key}:  #{log[key]}" }
      end
      logs = logs.join("\n")
      if Rails.env.development?
        puts logs
      else
        logger = Logger.new("#{Rails.root.join('log/mail.log')}")
        logger.info(logs)
      end
      return no_err
    end
  rescue StandardError => e
    LoggerService.new(exception: e, request: nil).call
  end

  def safe_from(tmp_email)
    MAIL_TEST_MODE ? 'egg-eart-soul+from@temona.co.jp' : tmp_email
  end

  def safe_to(tmp_email)
    MAIL_TEST_MODE ? 'egg-eart-soul+to@temona.co.jp' : tmp_email
  end
end
