class UserLifeplanQuery < ApplicationQuery
  like_attributes :name
  DATE_ATTRIBUTES = %i[review_requested_at review_completed_at basis_on].freeze
  DATE_ATTRIBUTES.each do |date_attribute|
    attribute :"#{date_attribute}", :date
    attribute :"#{date_attribute}_from", :date
    attribute :"#{date_attribute}_to", :date
  end
  equal_attributes :user_lifeplan_status_id

  class << self
    def permit_params
      %i[user_lifeplan_status_id] +
        date_permit_params(DATE_ATTRIBUTES)
    end

    def target_records
      super.reorder(id: :desc)
    end

    def date_attributes
      DATE_ATTRIBUTES
    end
  end
end

