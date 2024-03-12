module BaseAuthenticatable
  extend ActiveSupport::Concern
  included do
    attr_accessor :password, :password_confirmation

    validates :password, presence: {}, length: { within: 6..20 }, on: :create
    validates :password, presence: {}, length: { within: 6..20 }, on: :update, if: :use_password?
    validates :password, confirmation: { if: :use_password? }

    before_save :generate_hashed_password
  end

  def use_password?
    password.present?
  end

  def generate_hashed_password
    self.salt = self.class.new_salt if self.salt.blank?
    if self.password.present?
      self.hashed_password = self.class.hash_password(self.password, self.salt,
                                                      self.class.auth_magic)
    end
  end

  class_methods do
    def permit_params
      super + %i[
        password password_confirmation
      ]
    end

    def hash_password(password, salt, magic = auth_magic)
      OpenSSL::HMAC.hexdigest('sha256', salt, "#{password}:#{magic}")
    end

    def create_password
      # return  SecureRandom.hex(4).downcase
      o = [('a'..'z'), ('0'..'9')].map { |i| i.to_a }.flatten
      (0...8).map { o[rand(o.length)] }.join.downcase
    end

    def new_salt
      ('a'..'z').to_a.sample(10).join
    end

    def auth_magic = 'E6DcPVwMvqhBdsFqDGCpdsiJEYPVFBTdaw9YU'

    def authenticate(params)
      tmp = find_email(params[:email])
      if tmp && (tmp.hashed_password == hash_password(params[:password], tmp.salt, auth_magic))
        tmp.update_columns(last_logined_at: Time.now)
        return tmp
      end

      false
    end

    def find_email(email)
      return nil if email.blank?

      alive_record(email:)
    end
  end
end
