module RequestMethodSetting
  extend ActiveSupport::Concern
  included do
    enumerize :request_method, in: Settings.enum.request_method.to_h, scope: true, default: :get
  end

  def use_query?
    request_method.get? ||
      request_method.delete?
  end

  def use_body?
    request_method.post? || request_method.patch?
  end

  class_methods do
  end
end
