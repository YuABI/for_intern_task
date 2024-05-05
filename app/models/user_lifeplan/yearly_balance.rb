class UserLifeplan
  class YearlyBalance
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::AttributeMethods
    attribute :first_year, :integer, default: { Time.current.year }
    attribute :last_year, :integer
    attribute :user_lifeplan_id, :integer
    attribute :user, :integer
    attribute :yearly_balance, :hash, default: {}

    def user_lifeplan
      @user_lifeplan ||= UserLifeplan.find(user_lifeplan_id)
    end

    def user
      @user ||= user_lifeplan.user
    end

    def calculate
      set_last_year
    end

    private

    def set_last_year
      return if last_year.present?

    end
  end
end
