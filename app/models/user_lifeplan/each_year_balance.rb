class UserLifeplan
  class EachYearBalance < Struct.new(:year, :user, :age, :cash_deposits_amount, :other_assets_amount,
                                     :pension_amount, :cache_income_amount, :temporary_cache_income_amount,
                                     :spending_amount, :life_event_amount, :elderly_facility_amount, :end_of_life_amount)
  end
end
