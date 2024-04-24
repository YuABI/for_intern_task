class OrganizationDecorator < ApplicationDecorator
  class << self
    def required_codes
      %i[name]
    end

    def header_objects
      model = eval(self.model_name.name.camelize)
      [
        model.human(:id),
        model.human(:name),
        model.human(:tel),
      ]
    end

    def body_objects
      [
        'id',
        'name',
        'tel',
      ]
    end

    def form_objects(f)
      [
        [
          init_form(f, { code: :name, input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin), placeholder: ''), col: 6}),
        ],
        [
          init_form(f, { code: :zip, input: f.text_field(:zip, class: f.object.decorate.input_class(:zip, :admin), placeholder: ''), col: 2 }),
          init_form(f, { code: :pref, input: f.text_field(:pref, class: f.object.decorate.input_class(:pref, :admin), placeholder: ''), col: 4 }),
        ],
        [
          init_form(f, { code: :city, input: f.text_field(:city, class: f.object.decorate.input_class(:city, :admin), placeholder: ''), col: 4 }),
          init_form(f, { code: :address1, input: f.text_field(:address1, class: f.object.decorate.input_class(:address1, :admin), placeholder: ''), col: 4 }),
          init_form(f, { code: :address2, input: f.text_field(:address2, class: f.object.decorate.input_class(:address2, :admin), placeholder: ''), col: 4 }),
        ],
        [
          init_form(f, { code: :tel, input: f.text_field(:tel, class: f.object.decorate.input_class(:tel, :admin), placeholder: ''), col: 4 }),
          init_form(f, { code: :fax, input: f.text_field(:fax, class: f.object.decorate.input_class(:fax, :admin), placeholder: ''), col: 4 }),
        ]
      ]
    end

  end
end
