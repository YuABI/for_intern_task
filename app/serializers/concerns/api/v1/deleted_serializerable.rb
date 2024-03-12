module Api
  module V1
    module DeletedSerializerable
      extend ActiveSupport::Concern

      included do
        attributes :deleted
      end
    end
  end
end
