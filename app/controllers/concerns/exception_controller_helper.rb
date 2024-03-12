module ExceptionControllerHelper
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :render_500 if Rails.env.production?

    def exception_error
      raise Exception, params[:path]
    end

    def render_500(error = nil)
      logger.fatal '[FATAL] 例外が発生しました。'
      if error.present?
        LoggerService.new(exception: error, request:).call
      end
      render template: 'errors/exception', status: :internal_server_error, layout: 'error', content_type: 'text/html'
    end
  end
end
