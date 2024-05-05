class UserLifeplan
  class YearlyBalance
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::AttributeMethods
    attribute :first_year, :integer, default: { Time.current.year }
    attribute :last_year, :integer
    attribute :user_lifeplan_id, :integer
    attribute :user, :integer
    attribute :each_year_balances, :hash, default: {}

    def user_lifeplan
      @user_lifeplan ||= UserLifeplan.find(user_lifeplan_id)
    end

    def user
      @user ||= user_lifeplan.user
    end

    def calculate
      set_last_year

      first_year.upto(last_year) do |year|
        pension_amount = 0
        pension_incomes.each do |pension_income|
          pension_amount += pension_income.yearly_amount if is_in_payment_period?(pension_income, year)
        end

        each_year_balance = UserLifeplan::EachYearBalance.new(
          year: year, user: user, age: ( user.age || 70 ) + year - first_year,
          cash_deposits_amount: , other_assets_amount: ,
          pension_amount: , cache_income_amount: , temporary_cache_income_amount: ,
          spending_amount: , life_event_amount: , elderly_facility_amount: , end_of_life_amount: ,
        )
        each_year_balances[year] = each_year_balance
      end
    end

    private

    def is_in_payment_period?(income_or_expense, year)
      (income_or_expense.payment_start_on && income_or_expense.payment_start_on&.year < year) ||
              (income_or_expense.payment_end_on && income_or_expense.payment_end_on&.year > year)
    end

    def set_last_year
      return if last_year.present?
      self.last_year = first_year

      user_lifeplan.each do |user_lifeplan_income|
        if user_lifeplan_income.payment_end_on.year > last_year
          self.last_year = user_lifeplan_income.payment_end_on.year
        end
      end

      user_lifeplan.each do |user_lifeplan_expense|
        if user_lifeplan_expense.payment_end_on.year > last_year
          self.last_year = user_lifeplan_expense.payment_end_on.year
        end
      end

      if last_year == first_year
        diff = 95 - ( user.age || 70 ) + 1
        self.last_year = first_year + diff
      end
    end


    def pension_incomes
      @pension_incomes ||= user_lifeplan_incomes.with_user_lifeplan_income_kind(:pension)
    end

    def cache_incomes
      @cache_incomes ||= user_lifeplan_incomes.with_user_lifeplan_income_kind(:cache_income)
    end

    def temporary_cache_incomes
      @temporary_cache_incomes ||= user_lifeplan_incomes.with_user_lifeplan_income_kind(:temporary_cache_income)
    end

    def spending_expenses
      @spending_expenses ||= user_lifeplan_expenses.with_user_lifeplan_expense_kind(:spending)
    end

    def life_event_expenses
      @life_event_expenses ||= user_lifeplan_expenses.with_user_lifeplan_expense_kind(:life_event)
    end

    def elderly_facility_expenses
      @elderly_facility_expenses ||= user_lifeplan_expenses.with_user_lifeplan_expense_kind(:elderly_facility)
    end

    def end_of_life_expenses
      @end_of_life_expenses ||= user_lifeplan_expenses.where(user_lifeplan_expense_kind: %i[end_of_life deposit])
    end

    def cash_deposit_assets
      @cash_deposit_assets ||= user_lifeplan_assets.with_asset_kind(:cash_deposit)
    end

    def other_assets
      @other_assets ||= user_lifeplan_assets.with_asset_kind(:other_assets)
    end

    def user_lifeplan_assets
      @user_lifeplan_assets ||= user_lifeplan.user_lifeplan_assets
    end

    def user_lifeplan_incomes
      @user_lifeplan_incomes ||= user_lifeplan.user_lifeplan_incomes
    end

    def user_lifeplan_expenses
      @user_lifeplan_expenses ||= user_lifeplan.user_lifeplan_expenses
    end
  end
end
