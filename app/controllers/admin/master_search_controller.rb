module Admin
  class MasterSearchController < ::Admin::MasterController
    def _query_
      eval("#{name_singularize.camelize}Query", binding, __FILE__, __LINE__)
    end

    def index
      super
      query   = _query_.new(admin_query_params)
      objects = query.call(load_condition: true,
                           paginate: {},
                           admin_user: @current_admin_user)
      instance_set(name_pluralize, objects)
      instance_set('query', query)
    end

    def search
      query   = _query_.new(admin_query_params)
      objects = query.call(load_condition: false,
                           paginate: { page: params[:page], par: params[:par], order: params[:order] },
                           admin_user: @current_admin_user)

      instance_set(name_pluralize, objects)
      instance_set('query', query)

      render_javascript do |page|
        page.replace_html('object_lists', partial: 'object_lists')
      end
    rescue StandardError => e
      LoggerService.new(exception: e, request:).call
    end

    def search_clear
      @query = _query_.condition_clear(admin_user: @current_admin_user)
      render_javascript do |page|
        page.replace_html('query_form', partial: 'query_form')
      end
    rescue StandardError => e
      LoggerService.new(exception: e, request:).call
    end
  end
end
