class UserLifeplanContactDecorator < ApplicationDecorator
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

    private

    def common_form_object(f)
      [
        [ init_form( f, {
          code: :user_lifeplan_contact_kind,
          input: f.select(:user_lifeplan_contact_kind,
                          UserLifeplanContact.user_lifeplan_contact_kind.values.map { |v| [v.text, v.value] }, {},
                          class: f.object.decorate.input_class(:user_lifeplan_contact_kind, :admin)),
          no_required: false, help: '', alert: ''
        }), ],
        [ init_form( f, {
          code: :contact_level_kind,
          input: f.select(:contact_level_kind,
                          UserLifeplanContact.contact_level_kind.values.map { |v| [v.text, v.value] }, {},
                          class: f.object.decorate.input_class(:contact_level_kind, :admin)),
          no_required: false, help: '', alert: ''
        }), ],
        [ init_form( f, {
            code: :docs,
            input: f.file_field(:docs, class: f.object.decorate.input_class(:docs, :admin), multiple: true),
            no_required: false, help: '', alert: ''
        }) ],
      ]
    end
  end
end
