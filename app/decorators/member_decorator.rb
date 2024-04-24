class MemberDecorator < ApplicationDecorator
  class << self
    def required_codes
      %i[family_name first_name email password]
    end

    def header_objects
      model = eval(self.model_name.name.camelize)
      [
        model.human(:id),
        model.human(:organization_id),
        model.human(:name),
        model.human(:email),
        model.human(:last_logined_at_to),
      ]
    end

    def body_objects
      [
        'id',
        'organization&.name',
        'family_name',
        'email',
        'strftime_at(:last_logined_at)',
      ]
    end

    def form_objects(f)
      [
        [
          init_form(f,{code: :organization_id, input: f.select(:organization_id, Organization.pluck(:name, :id),{include_blank: false},{class: "form-select select2 #{f.object.decorate.input_class(:organization_id,:admin)}" }),col: 6}),
        ],
        [
          init_form(f, { code: :family_name, input: f.text_field(:family_name, class: f.object.decorate.input_class(:family_name, :admin), placeholder: ''), col: 4 }),
          init_form(f, { code: :first_name, input: f.text_field(:first_name, class: f.object.decorate.input_class(:first_name, :admin), placeholder: ''), col: 4 }),
        ],
        [
          init_form(f, { code: :family_name_kana, input: f.text_field(:family_name_kana, class: f.object.decorate.input_class(:family_name_kana, :admin), placeholder: ''), col: 4 }),
          init_form(f, { code: :first_name_kana, input: f.text_field(:first_name_kana, class: f.object.decorate.input_class(:first_name_kana, :admin), placeholder: ''), col: 4 }),
        ],
        [
          init_form(f, { code: :email, input: f.text_field(:email, class: f.object.decorate.input_class(:email, :admin), placeholder: ''), col: 4 }),
          init_form(f, { code: :password, input: f.password_field(:password, class: f.object.decorate.input_class(:password, :admin), placeholder: ''), col: 4 }),
        ],
        [
          init_form(f, { code: :tel, input: f.telephone_field(:tel, class: f.object.decorate.input_class(:tel, :admin), placeholder: ''), col: 4 }),
          init_form(f, { code: :mobile_tel, input: f.telephone_field(:mobile_tel, class: f.object.decorate.input_class(:mobile_tel, :admin), placeholder: ''), col: 4 }),
        ],
        [
          init_form(f, { code: :available, input: f.check_box(:available, class: "#{f.object.decorate.input_class(:available, :admin)} form-check-input", placeholder: ''), col: 4 }),
        ]
      ]
    end

    def admin_query_form_objects(f)
      [
        [
          init_form(f, { code: :name, input: f.text_field(:name, class: input_class), col: 4 }),
          init_form(f, { code: :email, input: f.text_field(:email, class: input_class), col: 4 }),
        ],
        [
          init_form(f, { code: :last_logined_at_from, input: f.text_field(:last_logined_at_from, type: :date, class: input_class), col: 3 }),
          init_form(f, { code: :last_logined_at_to, input: f.text_field(:last_logined_at_to, type: :date, class: input_class), col: 3 }),
        ]
      ]
    end
  end
end
