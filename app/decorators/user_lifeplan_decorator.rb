class UserLifeplanDecorator < ApplicationDecorator
  delegate_all

  class << self
    def form_objects(f)
      [
        [
          init_form( f, {
            code: :name,
            input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin), placeholder: ''),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :status,
            input: f.number_field(:status, class: f.object.decorate.input_class(:status, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :background_reason,
            input: f.number_field(:background_reason, class: f.object.decorate.input_class(:background_reason, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :legal_heir,
            input: f.number_field(:legal_heir, class: f.object.decorate.input_class(:legal_heir, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :residue,
            input: f.number_field(:residue, class: f.object.decorate.input_class(:residue, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :relatives,
            input: f.number_field(:relatives, class: f.object.decorate.input_class(:relatives, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :household_disposal,
            input: f.number_field(:household_disposal, class: f.object.decorate.input_class(:household_disposal, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :real_estate_disposal,
            input: f.number_field(:real_estate_disposal, class: f.object.decorate.input_class(:real_estate_disposal, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :close_grave,
            input: f.number_field(:close_grave, class: f.object.decorate.input_class(:close_grave, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :funeral_memorial_policy,
            input: f.number_field(:funeral_memorial_policy, class: f.object.decorate.input_class(:funeral_memorial_policy, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          })
        ]
      ]
    end

  end

end
