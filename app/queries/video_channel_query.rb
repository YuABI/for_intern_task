class VideoChannelQuery < ApplicationQuery
    like_attributes :video_genre_id, :name
    DATE_ATTRIBUTES = [:updated_at].freeze
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
  
      def target_records
        super.reorder(id: :asc)
      end
  
      def date_attributes
        DATE_ATTRIBUTES
      end
    end
  end
  