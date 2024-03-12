class ApiResultQuery < ApplicationQuery
  equal_attributes :api_client_id, :api_status_id
  like_attributes :end_point
  DATE_ATTRIBUTES = [:request_at].freeze
  DATE_ATTRIBUTES.each do |date_attribute|
    attribute :"#{date_attribute}", :date
    attribute :"#{date_attribute}_from", :date
    attribute :"#{date_attribute}_to", :date
  end
  class << self
    def permit_params
      super +
        date_permit_params(DATE_ATTRIBUTES)
    end

    def date_attributes
      DATE_ATTRIBUTES
    end
  end
end
