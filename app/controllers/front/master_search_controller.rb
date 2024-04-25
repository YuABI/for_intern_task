module Front
  class MasterSearchController < ::Front::MasterController

    def _query_
      eval("#{name_singularize.camelize}Query", binding, __FILE__, __LINE__)
    end

    def index
      super
      query   = _query_.new(query_params)
      objects = query.call(load_condition: true,
                           paginate:       {},
                           user:     @current_user ,
      )
      instance_set(name_pluralize, objects)
      instance_set("query", query)
    end

    def search
      query   = _query_.new(query_params)
      objects = query.call(load_condition: false,
                           paginate:       {page: params[:page], per: params[:par],order: params[:order]},
                           user:     @current_user ,
                           )

      instance_set(name_pluralize, objects)
      instance_set("query", query)

      render_javascript do |page|
        page.replace_html("object_lists", partial: "object_lists")
      end
    rescue StandardError => e
      LoggerService.new(exception: e,request: request).call
    end

    def search_clear
      @query = _query_.condition_clear(user: @current_user)
      render_javascript do |page|
        page.replace_html("query_form", partial: "query_form")
      end
    rescue StandardError => e
      LoggerService.new(exception: e,request: request).call
    end
    private
    def query_params
      _query_params = {front_company_id: @current_company.id,front_shop_id: @mode_staff ? @current_shop.id : nil}
      return _query_params unless params[:"#{name_singularize}_query"]
      _query_params.merge(params.require(:"#{name_singularize}_query").permit(
        _query_.permit_params
      ))
    end

  end
end
