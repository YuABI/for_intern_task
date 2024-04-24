module Front
  class MasterController < ::Front::BaseController
    include Base::SetAction

    def index
      objects = _model_.shop_alive_records(@current_shop)
      puts objects.to_sql
      object_name = name_pluralize
      instance_set(object_name, objects)
    end

    def new
      obj = _model_.shop_new_record(@current_shop)
      instance_set(name_singularize, obj)
    end

    def edit
      obj = find_object
      return redirect_to(__send__("#{name_pluralize}_path")) unless obj
    end

    def show
      obj = find_object
      return redirect_to(__send__("#{name_pluralize}_path")) unless obj
    end

    def create(goto_ = nil)
      obj = instance_set(name_singularize, _model_.new(object_params))
      if obj.save
        flash[:notice] = "登録いたしました"
        if goto_ == :index
          redirect_to __send__("#{name_pluralize}_path")
        elsif !goto_.blank?
          redirect_to eval(goto_)
        else
          redirect_to __send__("edit_#{name_singularize}_path", obj)
        end
      else
        flash.now[:alert] = "登録に失敗しました"
        render action: :new
      end
    end

    def update(goto_ = nil)
      obj = find_object
      return redirect_to(__send__("#{name_pluralize}_path")) unless obj

      if obj.update(object_params)
        flash[:notice] = "更新いたしました"
        if goto_ == :index
          redirect_to __send__("#{name_pluralize}_path", obj)
        elsif !goto_.blank?
          redirect_to eval(goto_)
        else
          redirect_to __send__("edit_#{name_singularize}_path", obj)
        end
      else
        flash.now[:alert] = "更新に失敗しました"
        render action: :edit
      end
    end

    def destroy(goto_ = nil)
      obj = find_object
      return redirect_to(__send__("#{name_pluralize}_path")) unless obj
      return redirect_to(__send__("#{name_pluralize}_path")) unless obj.allow_delete?

      flash[:notice] = "削除いたしました"
      obj.safe_delete

      redirect_to goto_ || __send__("#{name_pluralize}_path")
    end

    def find_object
      obj = _model_.shop_custom_find_by(@current_shop,{id: params[:id]})
      instance_set(name_singularize, obj)
      obj
    end
    def find_or_initialize_object
      obj   = _model_.shop_custom_find_by(@current_shop,{id: params[:id]})
      obj ||= _model_.company_new_record(@current_shop)

      instance_set(name_singularize, obj)
      obj
    end


    private
    def object_params
      return {} unless params[:"#{name_singularize}"]
      params.require(:"#{name_singularize}").permit(
        _model_.permit_params
      )
    end
  end
end
