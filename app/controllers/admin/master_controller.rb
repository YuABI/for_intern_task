module Admin
  class MasterController < ::Admin::BaseController
    include BaseAction
    def index
      objects = _model_.alive_records
      object_name = name_pluralize
      instance_set(object_name, objects)
    end

    def show
      obj = find_object
      redirect_to(__send__("admin_#{name_pluralize}_path")) unless obj
    end

    def new
      obj = _model_.new
      instance_set(name_singularize, obj)
    end

    def edit
      obj = find_object
      redirect_to(__send__("admin_#{name_pluralize}_path")) unless obj
    end

    def create(goto_ = nil)
      obj = instance_set(name_singularize, _model_.new(admin_object_params))
      if obj.save
        flash[:notice] = '登録いたしました'
        if goto_ == :index
          redirect_to __send__("admin_#{name_pluralize}_path")
        elsif goto_.present?
          redirect_to eval(goto_)
        else
          redirect_to __send__("edit_admin_#{name_singularize}_path", obj)
        end
      else
        flash.now[:alert] = '登録に失敗しました'
        render action: :new
      end
    end

    def update(goto_ = nil)
      obj = find_object
      return redirect_to(__send__("admin_#{name_pluralize}_path")) unless obj

      if obj.update(admin_object_params)
        flash[:notice] = '更新いたしました'
        if goto_ == :index
          redirect_to __send__("admin_#{name_pluralize}_path", obj)
        elsif goto_.present?
          redirect_to eval(goto_)
        else
          redirect_to __send__("edit_admin_#{name_singularize}_path", obj)
        end
      else
        flash.now[:alert] = '更新に失敗しました'
        render action: :edit
      end
    end

    def destroy(goto_ = nil)
      obj = find_object
      return redirect_to(__send__("admin_#{name_pluralize}_path")) unless obj
      return redirect_to(__send__("admin_#{name_pluralize}_path")) unless obj.allow_delete?

      flash[:notice] = '削除いたしました'
      obj.safe_destroy

      redirect_to goto_ || __send__("admin_#{name_pluralize}_path")
    end

    def generate_csv
      @objects = _query_.new(admin_query_params).call(condition: :save,
                                                      paginate: false,
                                                      admin_user: @current_admin_user)

      render_javascript do |page|
        if @objects.blank?
          page.alert('出力データがありません。')
        else
          csv_options = { objects: @objects }
          (params[:csv_options] || {}).keys.each { |i| csv_options[i] = params[:csv_options][i] }
          csv_service = _csv_export_service_.new(**csv_options)
          csv_service.call
          page.send_file(file_name: csv_service.file_name)
        end
      end
    rescue StandardError => e
      LoggerService.new(exception: e, request:).call
    end

    def csv_import
      @csv_import_service = _csv_import_service_.new(csv_import_service_params)
      return if request.get?

      if @csv_import_service.call
        flash.now[:notice] = "#{@csv_import_service.success_count}件、取り込みに成功しました！"
      else
        flash.now[:import_errors] =
          "#{@csv_import_service.total_count}件中、#{@csv_import_service.error_count}件、取り込みに失敗しました！"
      end
    end

    def refresh_form
      obj = find_or_initialize_object
      obj.attributes = object_params
      instance_set(name_singularize, obj)

      render_javascript do |page|
        page.replace_html('form', partial: 'form')
      end
    rescue StandardError => e
      LoggerService.new(exception: e, request:).call
    end

    def find_object
      obj = _model_.custom_find_by({ id: params[:id] })
      instance_set(name_singularize, obj)
      obj
    end

    def find_or_initialize_object
      obj   = _model_.custom_find_by({ id: params[:id] })
      obj ||= _model_.new

      instance_set(name_singularize, obj)
      obj
    end

    private

    def admin_object_params
      return {} unless params[:"#{name_singularize}"]

      params.require(:"#{name_singularize}").permit(
        _model_.permit_params
      )
    end

    def admin_query_params
      return {} unless params[:"#{name_singularize}_query"]

      params.require(:"#{name_singularize}_query").permit(
        _query_.permit_params
      )
    end

    def csv_import_params
      return {} unless params[:"#{name_singularize}"]

      params.require(:"#{name_singularize}").permit(
        _model_.permit_params
      )
    end

    def csv_import_service_params
      return {} unless params[:"import_csv_#{name_singularize}_import_service"]

      params.require(:"import_csv_#{name_singularize}_import_service").permit(
        _csv_import_service_.permit_params
      )
    end
  end
end
