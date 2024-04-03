class UserLifeplanDecorator < ApplicationDecorator
  delegate_all

  def form_objects(f)
    [
      [
        init_form(f,
                  { code: :name, input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin), placeholder: ''),
                    col: 6, no_required: false, help: '', alert: '' }),
      ],
      [
        init_form(f,
                  { code: :status, input: f.text_field(:status, class: f.object.decorate.input_class(:status, :admin), placeholder: ''),
                    col: 6, no_required: false, help: '', alert: '' }),
      ],
      [
        init_form(f,
                  { code: :apply_reviewed_at, input: f.text_field(:apply_reviewed_at, class: f.object.decorate.input_class(:apply_reviewed_at, :admin), placeholder: ''),
                    col: 6, no_required: false, help: '', alert: '' }),
      ],
      [
        init_form(f,
                  { code: :reviewed_at, input: f.text_field(:reviewed_at, class: f.object.decorate.input_class(:reviewed_at, :admin), placeholder: ''),
                    col: 6, no_required: false, help: '', alert: '' }),
      ],
    ]
  end

end
