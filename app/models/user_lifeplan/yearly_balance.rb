class UserLifeplan
  class YearlyBalance
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::AttributeMethods
    attribute :first_year, :integer, default: -> { Time.current.year }
    attribute :last_year, :integer
    attribute :user_lifeplan_custom_id, :string
    attribute :user, :integer
    attribute :initial_cache_assets_total, :integer, default: ->  { 0 }
    attribute :initial_other_assets_total, :integer, default: -> { 0 }
    attribute :cache_assets_total, :integer, default: -> { 0 }
    attribute :other_assets_total, :integer, default: -> { 0 }
    attribute :each_year_balances, default: -> { {} }

    def user_lifeplan
      @user_lifeplan ||= UserLifeplan.custom_find_by({ id: user_lifeplan_custom_id })
    end

    def user
      @user ||= user_lifeplan.user
    end

    def initial_assets_total
      initial_cache_assets_total + initial_other_assets_total
    end

    def calculate
      set_last_year
      set_initial_assets

      (first_year..last_year).each do |year|
        pension_amount = 0
        pension_incomes.each do |pension_income|
          pension_amount += pension_income.yearly_amount if is_in_payment_period?(pension_income, year)
        end

        cache_income_amount = 0
        cache_incomes.each do |cache_income|
          cache_income_amount += cache_income.yearly_amount if is_in_payment_period?(cache_income, year)
        end

        temporary_cache_income_amount = 0
        temporary_cache_incomes.each do |temporary_cache_income|
          if is_in_payment_period?(temporary_cache_income, year)
            temporary_cache_income_amount += temporary_cache_income.yearly_amount
          end
        end
        income_total = pension_amount + cache_income_amount + temporary_cache_income_amount

        spending_amount = 0
        spending_expenses.each do |spending_expense|
          if is_in_payment_period?(spending_expense, year) && is_per_year?(spending_expense, year)
            spending_amount += spending_expense.yearly_amount
          end
        end

        life_event_amount = 0
        life_event_expenses.each do |life_event_expense|
          if is_in_payment_period?(life_event_expense, year) && is_per_year?(life_event_expense, year)
            life_event_amount += life_event_expense.yearly_amount
          end
        end

        elderly_facility_amount = 0
        elderly_facility_expenses.each do |elderly_facility_expense|
          if is_in_payment_period?(elderly_facility_expense, year)
            elderly_facility_amount += elderly_facility_expense.yearly_amount
          end
        end

        end_of_life_amount = 0
        end_of_life_expenses.each do |end_of_life_expense|
          if is_in_payment_period?(end_of_life_expense, year) && is_per_year?(end_of_life_expense, year)
            end_of_life_amount += end_of_life_expense.yearly_amount
          end
        end
        expense_total = spending_amount + life_event_amount + elderly_facility_amount + end_of_life_amount

        other_assets.each do |other_asset|
          if other_asset.scheduled_for_sale == year
            self.other_assets_total = other_assets_total - other_asset.equity_appraisal_value
            self.cache_assets_total = cache_assets_total + other_asset.equity_appraisal_value
          end
        end
        self.cache_assets_total = cache_assets_total + income_total - expense_total
        cash_deposits_amount = cache_assets_total
        other_assets_amount = other_assets_total

        each_year_balance = UserLifeplan::EachYearBalance.new(
          year: year, user: user, age: ( user.age || 70 ) + year - first_year,
          cash_deposits_amount: , other_assets_amount: ,
          pension_amount: , cache_income_amount: , temporary_cache_income_amount: ,
          spending_amount: , life_event_amount: , elderly_facility_amount: , end_of_life_amount: ,
        )
        self.each_year_balances[year] = each_year_balance
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
      @cash_deposit_assets ||= user_lifeplan_assets.with_user_lifeplan_asset_kind(:cash_deposits)
    end

    def other_assets
      @other_assets ||= user_lifeplan_assets.with_user_lifeplan_asset_kind(:other_assets)
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

    private

    def is_per_year?(income_or_expense, year)
      return true if income_or_expense.pay_by_years == 0 || income_or_expense.pay_by_years == 1

      start_diff = (income_or_expense.payment_start_year || year) - year
      start_diff % income_or_expense.pay_by_years == 0
    end

    def is_in_payment_period?(income_or_expense, year)
      (income_or_expense.payment_start_year && income_or_expense.payment_start_year <= year) ||
              (income_or_expense.payment_end_year && income_or_expense.payment_end_year >= year)
    end

    def set_last_year
      return if last_year.present?
      self.last_year = first_year

      user_lifeplan.user_lifeplan_incomes.each do |user_lifeplan_income|
        next if user_lifeplan_income.payment_end_year.blank?

        if user_lifeplan_income.payment_end_year > last_year
          self.last_year = user_lifeplan_income.payment_end_year
        end
      end

      user_lifeplan.user_lifeplan_expenses.each do |user_lifeplan_expense|
        next if user_lifeplan_expense.payment_end_year.blank?

        if user_lifeplan_expense.payment_end_year > last_year
          self.last_year = user_lifeplan_expense.payment_end_year
        end
      end

      if last_year == first_year
        diff = 95 - ( user.age || 70 ) + 1
        self.last_year = first_year + diff
      end
    end

    def set_initial_assets
      self.initial_cache_assets_total = cash_deposit_assets.sum(:amount_of_money)
      self.initial_other_assets_total = other_assets.sum(:equity_appraisal_value)
      self.cache_assets_total = initial_cache_assets_total
      self.other_assets_total = initial_other_assets_total
    end
  end
end
