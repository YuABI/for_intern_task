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
      common_form_object(f)
    end

    def member_form_objects(member, f)
      common_form_object(f)
    end

    private

    def common_form_object(f)
      [
        [ init_form(f, {
          code: :name,
          input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin), placeholder: ''),
          col: 6, no_required: false, help: '', alert: ''
        }), ],
        [ init_form(f, {
          code: :user_lifeplan_income_kind,
          input: f.select(:user_lifeplan_income_kind,
                          UserLifeplanIncome.user_lifeplan_income_kind.values.map { |v| [v.text, v.value] }, {},
                          class: f.object.decorate.input_class(:user_lifeplan_income_kind, :admin)),
          col: 6, no_required: false, help: '', alert: ''
        }), ],
        [ init_form(f, {
          code: :cache_income_kind,
          input: f.select(:cache_income_kind,
                          UserLifeplanIncome.cache_income_kind.values.map { |v| [v.text, v.value] }, {},
                          class: f.object.decorate.input_class(:cache_income_kind, :admin)),
          col: 6, no_required: false, help: '', alert: ''
        }), ],
        [ init_form(f, {
          code: :pension_kind,
          input: f.select(:pension_kind,
                          UserLifeplanIncome.pension_kind.values.map { |v| [v.text, v.value] }, {},
                          class: f.object.decorate.input_class(:pension_kind, :admin)),
          col: 6, no_required: false, help: '', alert: ''
        }), ],
        [ init_form(f, {
            code: :content,
            input: f.text_field(:content,
                                class: f.object.decorate.input_class(:content, :admin), placeholder: ''),
            col: 6, no_required: false, help: '', alert: ''
          }), ],
        [ init_form(f, {
          code: :company_name,
          input: f.text_field(:company_name,
                              class: f.object.decorate.input_class(:company_name, :admin), placeholder: ''),
          col: 6, no_required: false, help: '', alert: ''
        }), ],
        [ init_form(f, {
          code: :payment_start_on,
          input: f.text_field(:payment_start_on,
                              class: f.object.decorate.input_class(:payment_start_on, :admin), type: :date),
          col: 6, no_required: false, help: '', alert: ''
        }), ],
        [ init_form(f, {
          code: :payment_end_on,
          input: f.text_field(:payment_end_on,
                              class: f.object.decorate.input_class(:payment_end_on, :admin), type: :date),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form(f, {
          code: :monthly_amount,
          input: f.number_field(:monthly_amount, class: f.object.decorate.input_class(:monthly_amount, :admin)),
          col: 6, no_required: false, help: '', alert: ''
        }) ]
      ]
    end
  end
end
