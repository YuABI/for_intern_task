class ApiResultDecorator < ApplicationDecorator
  class << self
    def required_codes
      []
    end

    def header_objects
      model = eval(self.model_name.name.camelize)
      [
        model.human(:id),
        model.human(:api_client_id),
        model.human(:end_point),
        model.human(:request_method),
        model.human(:api_status_id),
        model.human(:request_at),
      ]
    end

    def body_objects
      [
        'id',
        'api_client.name',
        'end_point',
        'request_method.text',
        'api_status.name',
        'strftime_at(:request_at)',
      ]
    end

    def form_objects(_f)
      []
    end

    def show_objects(_admin_user, obj)
      obj = obj.decorate
      [
        [
          { code: :id, value: obj.id, col: 12 },
          { code: :api_client_id, value: obj.api_client.name, col: 12 },
          { code: :end_point, value: obj.end_point, col: 12 },
          { code: :request_method, value: obj.request_method, col: 12 },
          { code: :request_body, value: obj.json_text_sub_html(:request_body), col: 12 },
          { code: :response_status, value: obj.response_status, col: 12 },
          { code: :response_body, value: obj.json_text_sub_html(:response_body), col: 12 },
          { code: :request_at, value: obj.strftime_at(:request_at), col: 12 },

        ],

      ]
    end

    def admin_query_form_objects(f)
      [
        [
          init_form(f,
                    { code: :api_client_id,
                      input: f.select(:api_client_id, ApiClient.alive_records.pluck(:name, :id), { include_blank: true }, { multiple: false, class: "select2 form-select #{input_class}" }), col: 3 }),
          init_form(f,
                    { code: :api_status_id,
                      input: f.select(:api_status_id, ApiStatus.pluck(:name, :id), { include_blank: true }, { multiple: false, class: "select2 form-select #{input_class}" }), col: 3 }),
          init_form(f, { code: :end_point, input: f.text_field(:end_point, class: input_class), col: 6 }),
        ], [
          init_form(f,
                    { code: :request_at_from, input: f.text_field(:request_at_from, type: :date, class: input_class),
                      col: 3 }),
          init_form(f,
                    { code: :request_at_to, input: f.text_field(:request_at_to, type: :date, class: input_class),
                      col: 3 }),
        ]

      ]
    end

    def action_links(_admin_user, object, write_form)
      links = []
      _exist  = object.exists_db?
      links << (if write_form && _exist && object.allow_edit?
                  h.link_to('詳細', h.__send__("admin_#{object.class.table_name.singularize}_path", object),
                            object.html_option.merge(class: "btn btn-sm btn-#{h.color_show}"))
                else
                  '-'
                end)
      links
    end

    def allow_new?
      false
    end
  end
end
