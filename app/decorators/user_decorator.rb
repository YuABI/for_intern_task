class UserDecorator < ApplicationDecorator
  #### クラスメソッドとして定義 ####
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
        model.human(:sex),
        model.human(:birthday),
        model.human(:address_info),
        model.human(:last_logined_at),
      ]
    end

    def body_objects
      [
        'id',
        'name',
        'email',
        'sex.text',
        'birthday',
        'user_address.decorate.join_address_with_zip_and_name',
        'strftime_at(:last_logined_at)',
      ]
    end

    def form_objects(f)
      [
        [
          init_form(f,
                    { code: :email, input: f.text_field(:email, class: f.object.decorate.input_class(:email, :admin), placeholder: ''),
                      col: 3 }),
          init_form(f,
                    { code: :password,
                      input: f.password_field(:password, class: f.object.decorate.input_class(:password, :admin), placeholder: ''), col: 3 }),
          init_form(f,
                    { code: :sex,
                      input: f.select(:sex, f.object.class.sex.options, {}, { class: "form-select #{f.object.decorate.input_class(:sex, :admin)}" }), help: '', col: 3 }),
          init_form(f,
                    { code: :birthday,
                      input: f.date_field(:birthday, class: f.object.decorate.input_class(:birthday, :admin), placeholder: ''), col: 3 }),

        ],
      ]
    end

    def admin_query_form_objects(f)
      [
        [
          init_form(f, { code: :email, input: f.text_field(:email, class: input_class), col: 3 }),
          init_form(f,
                    { code: :last_logined_at_from,
                      input: f.text_field(:last_logined_at_from, type: :date, class: input_class), col: 3 }),
          init_form(f,
                    { code: :last_logined_at_to,
                      input: f.text_field(:last_logined_at_to, type: :date, class: input_class), col: 3 }),
        ],
      ]
    end

    def admin_csv_export?
      true
    end

    def admin_csv_import?
      true
    end
  end

  def name
    addresses.first&.name
  end
end
