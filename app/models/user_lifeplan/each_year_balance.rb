class UserLifeplan
  class EachYearBalance < Struct.new(:year, :user, :age, :cash_deposits_amount, :other_assets_amount,
                                     :pension_amount, :cache_income_amount, :temporary_cache_income_amount,
                                     :spending_amount, :life_event_amount, :elderly_facility_amount, :end_of_life_amount)

    def incomes_amount_total
      pension_amount.to_i + cache_income_amount.to_i + temporary_cache_income_amount.to_i
    end

    def expenses_amount_total
      spending_amount.to_i + life_event_amount.to_i + elderly_facility_amount.to_i + end_of_life_amount.to_i
    end

    def assets_total
      cash_deposits_amount.to_i + other_assets_amount.to_i
    end

    def yearly_balance
      incomes_amount_total - expenses_amount_total
    end
  end
end
