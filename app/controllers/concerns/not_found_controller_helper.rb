module NotFoundControllerHelper
  extend ActiveSupport::Concern

  included do
    if Rails.env.production?
      rescue_from ActiveHash::RecordNotFound, with: :render_404
      rescue_from ActiveRecord::RecordNotFound, with: :render_404
      rescue_from ActionController::RoutingError, with: :render_404
    end

    def routing_error
      raise ActionController::RoutingError, params[:path]
    end

    def render_404(_error = nil)
      render template: 'errors/not_found', status: :not_found, layout: 'error', content_type: 'text/html'
    end
  end
end
