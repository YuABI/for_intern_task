module Api
  module V1
    class ApplicationSerializer < ActiveModel::Serializer
      # include JSONAPI::Serializer
      attributes :id, :created_at, :updated_at
      class << self
        def standard_serializable(obj, options)
          # {json: new(obj,options).serializable_hash}
          json_options = { json: obj, adapter: :json }.merge(options)
          if obj.is_a?(ActiveRecord::Relation)
            json_options[:each_serializer] = self
          else
            json_options[:serializer] = self
          end
          json_options
        end

        def bulk_serializable(options)
          { json: options }
        end
      end
    end
  end
end
