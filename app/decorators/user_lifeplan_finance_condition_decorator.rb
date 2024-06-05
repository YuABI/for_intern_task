class UserLifeplanFinanceConditionDecorator < ApplicationDecorator
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
    def form_objects(user, f)
      if user.is_a?(AdminUser)
        admin_form_objects(user, f)
      else
        member_form_objects(user, f)
      end
    end

    def member_form_objects(member, f)
      common_form_object(f)
    end

    def admin_form_objects(admin, f)
      common_form_object(f)
    end

    def codes
      %i[until_submitted_on content account account_info balance confirmed_on docs user_lifeplan_finance_condition_status_id]
    end

    private

    def common_form_object(f)
      [
        [ init_form( f, {
            code: :until_submitted_on,
            input: f.text_field(:until_submitted_on,
                                class: f.object.decorate.input_class(:until_submitted_on, :admin), type: :date),
            col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
            code: :content,
            input: f.text_area(:account, class: f.object.decorate.input_class(:account, :admin)),
            col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
            code: :account,
            input: f.text_field(:account, class: f.object.decorate.input_class(:account, :admin)),
            col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
            code: :account_info,
            input: f.text_field(:account_info, class: f.object.decorate.input_class(:account_info, :admin)),
            col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
            code: :balance,
            input: f.text_field(:balance, class: f.object.decorate.input_class(:balance, :admin)),
            col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
            code: :confirmed_on,
            input: f.text_field(:confirmed_on, class: f.object.decorate.input_class(:confirmed_on, :admin), type: :date),
            col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
            code: :docs,
            input: f.file_field(:docs, class: f.object.decorate.input_class(:docs, :admin), multiple: true,
                                       onchange: 'customDirectUploads(this)',
                                       data: { 'hidden-input-name': 'user_lifeplan[contact_note_docs][]'}
                               ),
            col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
            code: :user_lifeplan_finance_condition_status_id,
            input: f.select(:user_lifeplan_finance_condition_status_id,
                            UserLifeplanFinanceConditionStatus.all.map { |status| [status.name, status.id] }, {},
                            class: f.object.decorate.input_class(:user_lifeplan_finance_condition_status_id, :admin)),
            col: 6, no_required: false, help: '', alert: ''
        }) ]
      ]
    end
  end
end
