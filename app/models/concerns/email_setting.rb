module EmailSetting
  extend ActiveSupport::Concern
  included do
    validates :email, presence: {}, format: Regex::EMAIL
    validates :email, confirmation: {}
    validates :email, uniqueness: { scope: %i[deleted] }
    composed_of_email(:composed_email, 'email')
  end

  class_methods do
    def permit_params
      super + [
        :email_confirmation,
      ]
    end
  end
end
