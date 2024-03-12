# 自動返信メール（Meesagesテーブル関連）の処理を統合
class AutoReplyMailer < ApplicationMailer
  def self.safe_deliver(method, args, log: {})
    system_config = SystemConfig.target_record
    args[:system_config] = system_config
    args[:from_email] = system_config.send_mail_address
    args[:from_sender] = system_config.contact_shop

    return false if args[:header]&.use_flg&.unavailable? || args[:body]&.use_flg&.unavailable? # unless Rails.env.development? # 開発環境ではメールは飛ばす。コミットされていたら消す

    bcc = (args[:header]&.shop_bcc&.available? || args[:body]&.shop_bcc&.available?)
    args[:mobile] = args[:user].composed_email.carrier?
    %w[user shop].each do |send|
      if send == 'user'
        # 重要項目から、メルマガ配信ステータスのチェック有無を判断
        if SystemConfig.target_record.mail_send.available? && args[:user].mailmagazine_accepted.impossible?
          # 配信不可は送らないようにスキップ（userのみ）
          next
        end

        args[:to_email] = args[:user].email
        args[:bcc] = system_config.recv_mail_address if bcc
      else
        # ショップへの配信がbccであれば送らない。（shopのみ）
        next if bcc

        args[:to_email] = system_config.recv_mail_address
      end

      super(method, args)
    end
  rescue StandardError => e
    LoggerService.new(exception: e, request: nil).call
  end
end
