module Api
  module V1
    class BaseController < Api::BaseController
      include Api::V1::BaseAction

      after_action :create_api_result, except: [:access_tokens]
      def access_tokens
        api_client = ApiClient.find_by(
          api_key: params[:client_id],
          api_secret_key: params[:client_secret]
        )
        return render_invalid_client unless api_client
        return render_internal_server_error('can not generate_access_token') unless api_client.generate_access_token

        render json: { access_token: api_client.api_access_token }
      end

      def index
        objects = _query_.new(api_query_params).call(
          load_condition: false,
          paginate: { page: params[:page], per: params[:per], order: params[:order] }
        )

        render_json(objects, {
                      include: include_options,
                      meta: paginate_options(objects),
                    })
      end

      def show
        obj = find_object
        return render_not_found("id: #{params[:id].to_i} not found") unless obj

        render_json(obj, { include: include_options })
      end

      def create
        obj = instance_set(name_singularize, _model_.new(api_object_params))

        return render_bad_request(obj) unless obj.api_create

        render_json(obj, { include: include_options })
      end

      def update
        obj = find_object
        return render_not_found("id: #{params[:id].to_i} not found") unless obj
        return render_bad_request("id: #{params[:id].to_i} uneditable") unless obj.allow_edit?

        obj.assign_attributes(api_object_params)
        return render_bad_request(obj) unless obj.api_update

        render_json(obj, { include: include_options })
      end

      def destroy
        obj = find_object
        return render_not_found("id: #{params[:id].to_i} not found") unless obj
        return render_bad_request("id: #{params[:id].to_i} undeliteable") unless obj.allow_delete?
        return render_bad_request(obj) unless obj.api_destroy

        render_json(obj, { include: include_options })
      end

      def bulk_create
        render_bulk_json(
          _model_.bulk_create(api_bulk_create_objects_params)
        )
      end

      def bulk_update
        render_bulk_json(
          _model_.bulk_update(api_bulk_update_objects_params)
        )
      end

      def bulk_destroy
        render_bulk_json(
          _model_.bulk_destroy(api_bulk_destroy_objects_params)
        )
      end

      def create_validation
        obj = instance_set(name_singularize, _model_.new(api_object_params))

        return render_bad_request(obj) unless obj.api_valid?(target: api_target_list_params)

        render_json(obj, { include: include_options })
      end

      def update_validation
        obj = find_object
        return render_not_found("id: #{params[:id].to_i} not found") unless obj
        return render_bad_request("id: #{params[:id].to_i} uneditable") unless obj.allow_edit?

        obj.assign_attributes(api_object_params)

        return render_bad_request(obj) unless obj.api_valid?(target: api_target_list_params)

        render_json(obj, { include: include_options })
      end

      def save_associations(mode, **args)
        obj                  = args[:object]
        association_model    = args[:association_model]
        change_history_code  = args[:change_history_code]
        association_include  = args[:include_options] || include_options

        return render_not_found('not found') unless obj
        return render_bad_request("id: #{obj.id.to_i} uneditable") unless obj.allow_edit?

        obj.assign_attributes(send("api_#{mode}_associations_params", **args))
        return render_bad_request(obj) unless obj.send("api_#{mode}_associations", association_model,
                                                       change_history_code:)

        render_json(obj, { include: association_include })
      end

      def create_associations(**args)
        save_associations(:create, **args)
      end

      def update_associations(**args)
        save_associations(:update, **args)
      end

      def find_object
        obj = _model_.find_by({ id: params[:id] })
        instance_set(name_singularize, obj)
        obj
      end

      def find_or_initialize_object
        obj   = _model_.find_by({ id: params[:id] })
        obj ||= _model_.new
        instance_set(name_singularize, obj)
        obj
      end

      def render_json(objects, options = {})
        render _serializer_.standard_serializable(objects, options)
      end

      def render_bulk_json(objects, _options = {})
        render _serializer_.bulk_serializable(
          objects
        )
      end

      def create_api_result
        @api_client.create_results(request:, params:, response:)
      rescue StandardError => e
        LoggerService.new(exception: e, request:).call
      end

      protected

      def include_options
        []
      end

      def paginate_options(objects)
        return { total_count: 0, count: 0 } if objects.blank?

        {
          total_count: objects.total_count,
          page: objects.current_page,
          per: objects.size,
          count: objects.count,
          total_pages: objects.total_pages,
        }
      end

      def api_target_list_params
        params.dig(:target, name_singularize.to_sym) || []
      end

      def api_object_params
        return {} unless params[:"#{name_singularize}"]

        params.require(:"#{name_singularize}").permit(
          _model_.permit_params
        )
      end

      def api_bulk_create_objects_params
        return {} unless params[:"#{controller_name}"]

        params.permit("#{controller_name}": _model_.bulk_create_permit_params)
      end

      def api_bulk_update_objects_params
        return {} unless params[:"#{controller_name}"]

        params.permit("#{controller_name}": _model_.bulk_update_permit_params)
      end

      def api_bulk_destroy_objects_params
        return {} unless params[:"#{controller_name}"]

        params.permit("#{controller_name}": _model_.bulk_destroy_permit_params)
      end

      def api_associations_params(mode, **args)
        object            = args[:object]
        association_model = args[:association_model]
        model = object.class.table_name.singularize
        return {} unless params[:"#{model}"]

        params.require(:"#{model}").permit(
          object.class.send("#{mode}_#{association_model.to_s.pluralize}_permit_params")
        )
      end

      def api_create_associations_params(**args)
        api_associations_params(:create, **args)
      end

      def api_update_associations_params(**args)
        api_associations_params(:update, **args)
      end

      def api_query_params
        return {} unless params[:query]

        params.require(:query).permit(
          _query_.permit_params
        )
      end
    end
  end
end
