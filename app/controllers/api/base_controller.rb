module Api
  class BaseController < ActionController::API
    BEARER_TOKEN_REGEX = /^Bearer /

    before_action :system_initialize
    before_action :api_available?
    before_action :authenticate, except: [:access_tokens]
    before_action :maintenance_mode

    rescue_from StandardError, with: :render_internal_server_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def api_available?
      true
    end

    def authenticate
      authorization_header = request.authorization
      token = authorization_header.gsub(BEARER_TOKEN_REGEX, '') if authorization_header&.match BEARER_TOKEN_REGEX
      return render_invalid_client if token.blank?

      @api_client = ApiClient.find_by(api_access_token: token)
      render_invalid_token unless @api_client&.unexpired?
    end

    def system_initialize
      @target_config = SystemConfig.target_record
    end

    def maintenance_mode
      return true
      render json: {}, status: :service_unavailable
    end

    def render_success(json_options = {})
      render json: json_options, status: :ok
    end

    def render_invalid_token
      headers['WWW-Authenticate'] = 'Bearer error=invalid_token ' \
                                    'error_description=the access_token is invalid or expired'
      head :unauthorized
    end

    def render_error_response(code, err_object = nil)
      description    = code
      error_messages = {}
      if err_object
        description = err_object
        if err_object.is_a?(ApplicationRecord)
          error_messages = err_object.generate_error_messages_json
          description    = err_object.errors.full_messages.join(',')
        else
          LoggerService.new(exception: err_object, request:).call
        end
      end
      render json: {
        error: code,
        error_description: description || code,
        errors: error_messages,
      }, status: code
    end

    def render_invalid_client(err_object = nil)
      render_unauthorized(err_object || 'the client_id or client_secret or both are invalid')
    end

    def render_unauthorized(err_object = nil)
      render_error_response(:unauthorized, err_object || 'unauthorized')
    end

    def render_not_found(err_object = nil)
      render_error_response(:not_found, err_object)
    end

    def render_bad_request(err_object = nil)
      render_error_response(:bad_request, err_object)
    end

    def render_internal_server_error(err_object = nil)
      render_error_response(:internal_server_error, err_object)
    end
  end
end
