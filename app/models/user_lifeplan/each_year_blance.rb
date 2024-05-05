class UserLifeplan
  class EachYearBalance
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::AttributeMethods
    attribute :year, :integer
    attribute :user
    attribute :cash_deposits_amount, :integer, default: { 0 }
    attribute :other_assets_amount, :integer, default: { 0 }
    attribute :pension, :integer, default: { 0 }
    attribute :cache_income, :integer, default: { 0 }
    attribute :temporary_cache_income, :integer, default: { 0 }
    attribute :spending, :integer, default: { 0 }
    attribute :life_event, :integer, default: { 0 }
    attribute :elderly_facility, :integer, default: { 0 }
    attribute :end_of_life, :integer, default: { 0 }

    def age
    end


  end
end
