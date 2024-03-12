class SystemConfigDecorator < ApplicationDecorator
  class << self
    def form_objects(f)
      [
        [
          init_form(f,
                    { code: :site_url,
                      input: f.text_field(:site_url, class: f.object.decorate.input_class(:site_url, :admin), placeholder: ''), col: 3, no_required: false, admin: true }),
        ],
      ]
    end

    def allow_new?
      false
    end
  end
end
