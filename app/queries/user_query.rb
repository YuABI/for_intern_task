class UserQuery < ApplicationQuery
  DATE_ATTRIBUTES = [:created_at].freeze
  MULTIPLE_ATTRIBUTES = %i[id email].freeze
  DATE_ATTRIBUTES.each do |date_attribute|
    attribute :"#{date_attribute}", :date
    attribute :"#{date_attribute}_from", :date
    attribute :"#{date_attribute}_to", :date
  end
  MULTIPLE_ATTRIBUTES.each do |multiple_attribute|
    attribute :"#{multiple_attribute}"
    attribute :"#{multiple_attribute}s"
  end
  equal_attributes :id
  class << self
    def permit_params
      %i[
        id
        email
      ] +
        date_permit_params(DATE_ATTRIBUTES) +
        multiple_permit_params(MULTIPLE_ATTRIBUTES)
    end

    def date_attributes
      DATE_ATTRIBUTES
    end

    def multiple_attributes
      MULTIPLE_ATTRIBUTES
    end
  end
end
