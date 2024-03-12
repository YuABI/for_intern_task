class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, except: [:destroy]
  include ExceptionControllerHelper
  include NotFoundControllerHelper
  include JavascriptResponseBuilder
  include HtmlTagHelper

  before_action :system_initialize
  before_action :auth_basic
  before_action :disable_mobile_view_if_tablet

  def system_initialize
    @target_config = SystemConfig.target_record
  end

  def auth_basic; end

  def request_get_or_head?
    return true if request.get?
    return true if request.head?

    false
  end

  private

  def disable_mobile_view_if_tablet
    request.variant = request.device_variant
    request.variant = :pc if request.from_android_tablet? || request.from_ipad?
  end
end
