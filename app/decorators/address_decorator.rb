class AddressDecorator < ApplicationDecorator
  include SupportAddressDecorator

  class << self
    def form_objects(f)
      [
        [
          init_form(f,
                    { code: :zip,
                      input: f.text_field(:zip, class: f.object.decorate.input_class(:zip, :admin), placeholder: ''), col: 3 }),
          init_form(f,
                    { code: :pref, input: f.text_field(:pref, class: f.object.decorate.input_class(:pref, :admin), placeholder: ''),
                      col: 3 }),
          init_form(f,
                    { code: :city, input: f.text_field(:city, class: f.object.decorate.input_class(:city, :admin), placeholder: ''),
                      col: 3 }),
          init_form(f,
                    { code: :address1,
                      input: f.text_field(:address1, class: f.object.decorate.input_class(:address1, :admin), placeholder: ''), col: 3 }),

        ], [
          init_form(f,
                    { code: :address2,
                      input: f.text_field(:address2, class: f.object.decorate.input_class(:address2, :admin), placeholder: ''), col: 3 }),
          init_form(f,
                    { code: :tel,
                      input: f.text_field(:tel, class: f.object.decorate.input_class(:tel, :admin), placeholder: ''), col: 3 }),

        ]
      ]
    end
  end
end
