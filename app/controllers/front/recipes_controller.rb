class Front::RecipesController < Front::MasterSearchController

  def has_role?
    super
    unless @current_user.all_company?
      @form_write = @current_shop.use_create_recipe.available?
    end
  end

  def new
    super
    @recipe.company_id = @current_company.id
    @recipe.shop_id = @current_shop.id
  end

  def copy
    obj = find_object
    return redirect_to(__send__("#{name_pluralize}_path")) unless obj
    obj = _model_.copy(obj, @current_shop)
    instance_set(name_singularize, obj)
    render action: :new
  end

  def add_recipe_item
    @recipe = Recipe.find_or_initialize_by(id: params[:id])
    @recipe.attributes = object_params
    @recipe.recipe_items.build(food_id: params[:food_id],covert_qty: params[:covert_qty])
    render_javascript do |page|
      page.replace_html("form",  partial: "form")
    end
  rescue StandardError => e
    LoggerService.new(exception: e,request: request).call
  end

  def mod_recipe_item
    @recipe = Recipe.find_or_initialize_by(id: params[:id])
    @recipe.attributes = object_params

    render_javascript do |page|
      page.replace_html("form",  partial: "form")
    end
  rescue StandardError => e
    LoggerService.new(exception: e,request: request).call
  end
  def find_object
    obj = _model_.custom_find_by({id: params[:id],company_id: @current_company.id})
    instance_set(name_singularize, obj)
    obj
  end
  private
  def query_params
    _query_params = super
    if @current_shop.recipe_mode_company?
      _query_params[:company_id] = @current_shop.company_id
    end
    _query_params
  end
end
