class UserLifeplanDecorator < ApplicationDecorator
  class << self
    def form_objects(f)
      common_form_object(f)
    end

    def member_form_objects(member, f)
      common_form_object(f, member)
    end

    private

    def common_form_object(f, member)
      [
        [
          init_form( f, {
            code: :user_id,
            # TODO: 顧客作成時にmemberとの紐付けが実装され次第、コメントアウトを外す
            # input: f.select(:user_id, member.users.map { |user| [user.name, user.id] }, { include_blank: true },
            #                 class: f.object.decorate.input_class(:name, :admin)),
            input: f.select(:user_id, User.all.map { |user| [user.full_name, user.id] }, { include_blank: true },
                            class: f.object.decorate.input_class(:name, :admin)  ),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
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
            input: f.select(:background_reason, UserLifeplan.background_reason.values.map { |v| [v.text, v.value] }, {}, class: f.object.decorate.input_class(:background_reason, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :background_reason_comment,
            input: f.text_area(:background_reason_comment, class: f.object.decorate.input_class(:background_reason_comment, :admin)),
            col: 6, no_required: false, help: '', alert: '', row: 10
          }),
        ],
        [
          init_form( f, {
            code: :legal_heir,
            input: f.select(:legal_heir, UserLifeplan.legal_heir.values.map { |v| [v.text, v.value] }, {}, class: f.object.decorate.input_class(:legal_heir, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :legal_heir_comment,
            input: f.select(:legal_heir_comment, UserLifeplan.legal_heir_comment.values.map { |v| [v.text, v.value] }, {}, class: f.object.decorate.input_class(:legal_heir_comment, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :residue,
            input: f.select(:residue, UserLifeplan.residue.values.map { |v| [v.text, v.value] }, {}, class: f.object.decorate.input_class(:residue, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :relatives,
            input: f.select(:relatives, UserLifeplan.relatives.values.map { |v| [v.text, v.value] }, {}, class: f.object.decorate.input_class(:relatives, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :relatives_comment,
            input: f.select(:relatives_comment, UserLifeplan.relatives_comment.values.map { |v| [v.text, v.value] }, {}, class: f.object.decorate.input_class(:relatives_comment, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :household_disposal,
            input: f.select(:household_disposal, UserLifeplan.household_disposal.values.map { |v| [v.text, v.value] }, {}, class: f.object.decorate.input_class(:household_disposal, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :real_estate_disposal,
            input: f.select(:real_estate_disposal, UserLifeplan.real_estate_disposal.values.map { |v| [v.text, v.value] }, {}, class: f.object.decorate.input_class(:real_estate_disposal, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :close_grave,
            input: f.select(:close_grave, UserLifeplan.close_grave.values.map { |v| [v.text, v.value] }, {}, class: f.object.decorate.input_class(:close_grave, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :funeral_memorial_policy,
            input: f.select(:funeral_memorial_policy, UserLifeplan.funeral_memorial_policy.values.map { |v| [v.text, v.value] }, {}, class: f.object.decorate.input_class(:funeral_memorial_policy, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          })
        ],
        [
          init_form( f, {
            code: :note,
            input: f.text_area(:note, class: f.object.decorate.input_class(:note, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          }),
        ],
      ]
    end
  end

end
