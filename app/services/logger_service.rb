class LoggerService < BaseService
  def initialize(exception:, request:)
    @exception = exception
    @request   = request
  end

  def call
    use_mail = !Rails.env.development?
    Rails.logger.debug exception
    p exception # 消さない！
    env = (request || Rails).env
    case true
    when exception.is_a?(ActiveRecord::RecordInvalid)
    when exception.is_a?(RuntimeError)
    when exception.is_a?(String), exception.is_a?(Array)
      err = exception
      err = exception.join("\n") if exception.is_a?(Array)
      send_notify(err, env) if use_mail
    else
      send_notify(exception, env) if use_mail
      exception.backtrace.each { |t| p t }
    end
  end

  private

  attr_reader :exception, :request

  def send_notify(exception, env)
    ExceptionNotifier.notify_exception(exception, env:)
  rescue StandardError => e
    Rails.logger.debug e
  end
end
