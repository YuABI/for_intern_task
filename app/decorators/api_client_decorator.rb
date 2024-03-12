class ApiClientDecorator < ApplicationDecorator
  include SupportDateDecorator
  class << self
    def required_codes
      [
        :name,
      ]
    end

    def header_objects
      model = eval(self.model_name.name.camelize)
      [
        model.human(:id),
        model.human(:name),
        model.human(:api_key),
        model.human(:api_access_token_expired_at),

      ]
    end

    def body_objects
      [
        'id',
        'name',
        'api_key',
        'strftime_at(:api_access_token_expired_at)',
      ]
    end

    def form_objects(f)
      [
        [
          init_form(f,
                    { code: :name, input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin), placeholder: ''),
                      col: 3 }),
        ],

      ]
    end

    def action_links(admin_user, object, write_form)
      links = []
      _exist  = object.exists_db?
      links << (if links
                  if write_form && _exist
                    h.link_to('API設定', h.api_key_admin_api_client_path(id: object),
                              object.html_option.merge(class: "btn btn-sm btn-rounded btn-soft-#{h.color_primary}"))
                  end
                else
                  ''
                end)
      links + super
    end
  end
end
