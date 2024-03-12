class AdminUserDecorator < ApplicationDecorator
  class << self
    def required_codes
      %i[name email password]
    end

    def header_objects
      model = eval(self.model_name.name.camelize)
      [
        model.human(:id),
        model.human(:name),
        model.human(:email),
        model.human(:last_logined_at_to),
      ]
    end

    def body_objects
      [
        'id',
        'name',
        'email',
        'strftime_at(:last_logined_at)',
      ]
    end

    def form_objects(f)
      [
        [
          init_form(f,
                    { code: :name, input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin), placeholder: ''),
                      col: 3 }),
          init_form(f,
                    { code: :email, input: f.text_field(:email, class: f.object.decorate.input_class(:email, :admin), placeholder: ''),
                      col: 3 }),
          init_form(f,
                    { code: :password,
                      input: f.text_field(:password, class: f.object.decorate.input_class(:password, :admin), placeholder: ''), col: 3 }),
        ],
      ]
    end

    def admin_query_form_objects(f)
      [
        [
          init_form(f, { code: :name, input: f.text_field(:name, class: input_class), col: 4 }),
          init_form(f, { code: :email, input: f.text_field(:email, class: input_class), col: 4 }),
        ], [
          init_form(f,
                    { code: :last_logined_at_from,
                      input: f.text_field(:last_logined_at_from, type: :date, class: input_class), col: 3 }),
          init_form(f,
                    { code: :last_logined_at_to,
                      input: f.text_field(:last_logined_at_to, type: :date, class: input_class), col: 3 }),
        ]
      ]
    end
  end
end
