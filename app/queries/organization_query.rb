class OrganizationQuery < ApplicationQuery
  like_attributes :name

  class << self
    def permit_params
      super
    end

    def target_records
      super.reorder(id: :asc)
    end

  end
end
