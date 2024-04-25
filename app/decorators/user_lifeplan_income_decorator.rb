class UserLifeplanIncomeDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  class << self
    def form_objects(f)
      [
        [
          init_form(
            f,
            { code: :name,
              input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin), placeholder: ''),
              col: 6, no_required: false, help: '', alert: '' }),
        ]
      ]
    end
  end
end
