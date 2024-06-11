class UserLifeplanDecorator < ApplicationDecorator
  class << self
    def form_objects(f)
      [
        [init_form( f, {
          code: :user_lifeplan_status_id,
          input: f.select(:user_lifeplan_status_id,
                          UserLifeplanStatus.all.map { |status| [status.name, status.id] }, {  },
                          class: f.object.decorate.input_class(:user_lifeplan_status_id, :admin)),
          col: 4, no_required: false, help: '', alert: ''
        })],
        [init_form( f, {
          code: :member_id,
          input: f.select(:member_id,
                          Member.all.map { |member| [member.full_name, member.id] }, {  },
                          class: f.object.decorate.input_class(:member_id, :admin)),
          col: 4, no_required: false, help: '', alert: ''
        })]
      ] + common_form_object(f)
    end

    def header_objects
      ['' , UserLifeplan.human_attribute_name(:user_id), UserLifeplan.human_attribute_name(:user_lifeplan_status_id)]
    end

    def body_objects
      %w[id user_name user_lifeplan_status_name]

    end

    def admin_action_links(_admin_user, object, write_form)
      links = []
      if object.id
        links << h.link_to('詳細', h.__send__("admin_#{object.class.table_name.singularize}_path", object),
                  object.html_option.merge(class: "btn btn-sm btn-secondary"))
      else
        links << ''
      end
      links+ action_links(_admin_user, object, write_form)
    end

    def member_form_objects(member, f)
      [
        [init_form( f, {
          code: :user_lifeplan_status_id,
          input: f.select(:user_lifeplan_status_id,
                          UserLifeplanStatus.all.map { |status| [status.name, status.id] }, {  },
                          class: f.object.decorate.input_class(:user_lifeplan_status_id, :admin), disabled: true),
          col: 4, no_required: false, help: '', alert: ''
        })]
      ] + common_form_object(f, member)
    end

    def admin_query_form_objects(f)
      [
        [ init_form(f, { code: :user_lifeplan_status_id,
                         input: f.select(:user_lifeplan_status_id,
                                         UserLifeplanStatus.all.map { |status| [status.name, status.id] },
                                         { include_blank: true }, class: input_class),
                         col: 4 })],
      ]
    end

    private

    def common_form_object(f, member = nil)
      [
        [
          init_form( f, {
            code: :user_id,
            # TODO: 顧客作成時にmemberとの紐付けが実装され次第、コメントアウトを外す
            # input: f.select(:user_id, member.users.map { |user| [user.name, user.id] }, { include_blank: true },
            #                 class: f.object.decorate.input_class(:name, :admin)),
            input: f.select(:user_id, User.all.map { |user| [user.full_name, user.id] }, { include_blank: true },
                            class: f.object.decorate.input_class(:user_id, :admin)  ),
            col: 4, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :basis_on,
            input: f.text_field(:basis_on, class: f.object.decorate.input_class(:status, :admin), type: :date),
            col: 4, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :start_pension_age,
            input: f.number_field(:start_pension_age, class: f.object.decorate.input_class(:start_pension_age, :admin)),
            col: 3, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :start_resident_elderly_facility_age,
            input: f.number_field(:start_resident_elderly_facility_age,
                                  class: f.object.decorate.input_class(:start_resident_elderly_facility_age, :admin)),
            col: 3, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :start_nursing_care_age,
            input: f.number_field(:start_nursing_care_age,
                                  class: f.object.decorate.input_class(:start_nursing_care_age, :admin)),
            col: 3, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :death_age,
            input: f.number_field(:death_age, class: f.object.decorate.input_class(:death_age, :admin)),
            col: 3, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :background_reason,
            input: f.select(:background_reason,
                            UserLifeplan.background_reason.values.map { |v| [v.text, v.value] }, {},
                            class: f.object.decorate.input_class(:background_reason, :admin)),
            col: 4, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :background_reason_comment,
            input: f.text_area(:background_reason_comment,
                               class: f.object.decorate.input_class(:background_reason_comment, :admin)),
            col: 6, no_required: false, help: '', alert: '', row: 10
          }),
        ],
        [
          init_form( f, {
            code: :legal_heir,
            input: f.select(:legal_heir,
                            UserLifeplan.legal_heir.values.map { |v| [v.text, v.value] }, {},
                            class: f.object.decorate.input_class(:legal_heir, :admin)),
            col: 5, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :legal_heir_comment,
            input: f.select(:legal_heir_comment,
                            UserLifeplan.legal_heir_comment.values.map { |v| [v.text, v.value] }, {},
                            class: f.object.decorate.input_class(:legal_heir_comment, :admin)),
            col: 4, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :residue,
            input: f.select(:residue,
                            UserLifeplan.residue.values.map { |v| [v.text, v.value] }, {},
                            class: f.object.decorate.input_class(:residue, :admin)),
            col: 4, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :relatives,
            input: f.select(:relatives,
                            UserLifeplan.relatives.values.map { |v| [v.text, v.value] }, {},
                            class: f.object.decorate.input_class(:relatives, :admin)),
            col: 4, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :relatives_comment,
            input: f.select(:relatives_comment,
                            UserLifeplan.relatives_comment.values.map { |v| [v.text, v.value] }, {},
                            class: f.object.decorate.input_class(:relatives_comment, :admin)),
            col: 4, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :household_disposal,
            input: f.select(:household_disposal,
                            UserLifeplan.household_disposal.values.map { |v| [v.text, v.value] }, {},
                            class: f.object.decorate.input_class(:household_disposal, :admin)),
            col: 3, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :real_estate_disposal,
            input: f.select(:real_estate_disposal,
                            UserLifeplan.real_estate_disposal.values.map { |v| [v.text, v.value] }, {},
                            class: f.object.decorate.input_class(:real_estate_disposal, :admin)),
            col: 3, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :close_grave,
            input: f.select(:close_grave,
                            UserLifeplan.close_grave.values.map { |v| [v.text, v.value] }, {},
                            class: f.object.decorate.input_class(:close_grave, :admin)),
            col: 3, no_required: false, help: '', alert: ''
          }),
        ],
        [
          init_form( f, {
            code: :funeral_memorial_policy,
            input: f.select(:funeral_memorial_policy,
                            UserLifeplan.funeral_memorial_policy.values.map { |v| [v.text, v.value] }, {},
                            class: f.object.decorate.input_class(:funeral_memorial_policy, :admin)),
            col: 3, no_required: false, help: '', alert: ''
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

  def user_name
    user&.full_name
  end

  def user_lifeplan_status_name
    user_lifeplan_status&.name
  end


  def input_class(attr, mode = :front)
    origin = super
    if %i[member_id user_id].include?(attr)
      origin += ' select2'
    end
    origin
  end

end
