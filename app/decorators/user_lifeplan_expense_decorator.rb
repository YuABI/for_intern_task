class UserLifeplanExpenseDecorator < ApplicationDecorator
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
      common_form_object(f)
    end

    def member_form_objects(member, f)
      common_form_object(f)
    end

    private

    def common_form_object(f)
      [
        [
          init_form(f, {
            code: :name,
            input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin), placeholder: ''),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form(f, {
            code: :expenditure_item_name,
            input: f.number_field(:expenditure_item_name, class: f.object.decorate.input_class(:expenditure_item_name, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form(f, {
            code: :user_lifeplan_id,
            input: f.number_field(:user_lifeplan_id, class: f.object.decorate.input_class(:user_lifeplan_id, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form(f, {
            code: :content,
            input: f.number_field(:content, class: f.object.decorate.input_class(:content, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form(f, {
            code: :company_name,
            input: f.text_field(:company_name, class: f.object.decorate.input_class(:company_name, :admin), placeholder: ''),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form(f, {
            code: :note,
            input: f.number_field(:note, class: f.object.decorate.input_class(:note, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form(f, {
            code: :user_lifeplan_expense_kind,
            input: f.select(:user_lifeplan_expense_kind, UserLifeplanExpense.user_lifeplan_expense_kind.values.map { |v| [v.text, v.value] }, {}, class: f.object.decorate.input_class(:user_lifeplan_income_kind, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form(f, {
            code: :payment_start_at,
            input: f.datetime_select(:payment_start_at, class: f.object.decorate.input_class(:payment_start_at, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form(f, {
            code: :payment_end_at,
            input: f.datetime_select(:payment_end_at, class: f.object.decorate.input_class(:payment_end_at, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form(f, {
            code: :monthly_amount,
            input: f.number_field(:monthly_amount, class: f.object.decorate.input_class(:monthly_amount, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form(f, {
            code: :pay_by_years,
            input: f.number_field(:pay_by_years, class: f.object.decorate.input_class(:pay_by_years, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form(f, {
            code: :yearly_amount,
            input: f.number_field(:yearly_amount, class: f.object.decorate.input_class(:yearly_amount, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ]
      ]
    end
  end
end
