module ValueComposable
  extend ActiveSupport::Concern
  included do
  end
  class_methods do
    ## バリューオブジェクト
    def composed_of_email(attr_name, org_col, **option)
      composed_of attr_name,
                  class_name: 'EmailValue', allow_nil: option[:allow_nil] || true,
                  mapping: [org_col.to_s, 'email_value'],
                  constructor: proc { |value| EmailValue.new(email_value: value) },
                  converter: proc { |value| EmailValue.new(email_value: value) },
                  **option
    end

    def composed_of_text(attr_name, org_col, **option)
      composed_of attr_name,
                  class_name: 'TextValue', allow_nil: option[:allow_nil] || true,
                  mapping: [org_col.to_s, 'text_value'],
                  constructor: proc { |value| TextValue.new(text_value: value) },
                  converter: proc { |value| TextValue.new(text_value: value) },
                  **option
    end

    def composed_of_url(attr_name, org_col, **option)
      composed_of attr_name,
                  class_name: 'UrlValue', allow_nil: option[:allow_nil] || true,
                  mapping: [org_col.to_s, 'url_value'],
                  constructor: proc { |value| UrlValue.new(url_value: value) },
                  converter: proc { |value| UrlValue.new(url_value: value) },
                  **option
    end
  end
end
