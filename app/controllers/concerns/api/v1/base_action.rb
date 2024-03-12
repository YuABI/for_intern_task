module Api
  module V1
    module BaseAction
      extend ActiveSupport::Concern
      included do
        before_action :set_action
      end
      def set_action; end

      def name_singularize
        controller_name.singularize
      end

      def name_pluralize
        controller_name
      end

      def instance_get(sym)
        instance_variable_get("@#{sym}")
      end

      def instance_set(sym, obj)
        instance_variable_set("@#{sym}", obj)
      end

      def _model_
        eval("#{name_singularize.camelize}::ApiWrapper", binding, __FILE__, __LINE__)
      end

      def _query_
        eval("#{name_singularize.camelize}Query", binding, __FILE__, __LINE__)
      end

      def _serializer_
        eval("Api::V1::#{name_singularize.camelize}Serializer", binding, __FILE__, __LINE__)
      end
    end
  end
end
