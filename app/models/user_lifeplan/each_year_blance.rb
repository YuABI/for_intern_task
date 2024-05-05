class UserLifeplan
  class EachYearBalance
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::AttributeMethods
    attribute :year, :integer
    attribute :user
    attribute :age, :integer
    attribute :cash_deposits_amount, :integer, default: { 0 }
    attribute :other_assets_amount, :integer, default: { 0 }
    attribute :pension_amount, :integer, default: { 0 }
    attribute :cache_income_amount, :integer, default: { 0 }
    attribute :temporary_cache_income_amount, :integer, default: { 0 }
    attribute :spending_amount, :integer, default: { 0 }
    attribute :life_event_amount, :integer, default: { 0 }
    attribute :elderly_facility_amount, :integer, default: { 0 }
    attribute :end_of_life_amount, :integer, default: { 0 }
  end
end
