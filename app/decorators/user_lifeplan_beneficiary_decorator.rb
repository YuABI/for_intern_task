class UserLifeplanBeneficiaryDecorator < ApplicationDecorator
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
            code: :name,
            input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin)),
            col: 4, no_required: false, help: '', alert: ''
        }) ],
      ]
    end
  end
end
