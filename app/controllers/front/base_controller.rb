module Front
  class BaseController < ApplicationController
    layout "front"
    before_action :authenticate!,:has_role? ,except: [:login,:logout,:from_mother]

    def from_mother
      admin_user = AdminUser.alive_record(id: session[:admin_user_id])
      shop       = Shop.alive_record(id: params[:shop_id])
      return logout unless admin_user
      return logout unless shop
      user                         = admin_user.mother_user
      session[:current_user_id]    = user.id
      session[:current_company_id] = shop.company_id
      session[:current_shop_id]    = shop.id
      return redirect_to params[:goto] || front_root_path
    end

    def target_shop
      shop = Shop.custom_find_by({id: params[:shop_id]})
      return logout unless shop
      session[:current_company_id] = shop.company_id
      session[:current_shop_id]    = shop.id
      return redirect_to front_root_path
    end

    def create_favorite
      @current_shop.create_favorite(params[:item_id])
      render_javascript do |page|
        page.code <<  "$('.favorite_item#{params[:item_id]}').removeClass('text-warning');"
        page.code <<  "$('.favorite_item#{params[:item_id]}').removeClass('text-secondary');"
        page.code <<  "$('.favorite_item#{params[:item_id]}').removeClass('bx-star');"
        page.code <<  "$('.favorite_item#{params[:item_id]}').removeClass('bxs-star');"


        if @current_shop.exists_favorite?(params[:item_id])
          page.code <<  "$('.favorite_item#{params[:item_id]}').addClass('text-warning');"
          page.code <<  "$('.favorite_item#{params[:item_id]}').addClass('bxs-star');"
        else
          page.code <<  "$('.favorite_item#{params[:item_id]}').addClass('text-secondary');"
          page.code <<  "$('.favorite_item#{params[:item_id]}').addClass('bx-star');"
        end
      end
    rescue StandardError => e
      LoggerService.new(exception: e,request: request).call
    end
    def login
      if request.post?
        @current_user = User.authenticate(front_user_params)
      elsif request.get?
        return render
      end

      if @current_user
        session[:current_user_id]    = @current_user.id
        company                      = @current_user.company || Company.available_records.first
        session[:current_company_id] = company.id
        session[:current_shop_id]    = @current_user.shop&.id || company.shops.alive_records.first&.id
        redirect_to front_root_path, notice: 'ログインしました。'
      else
        flash[:alert] = "ログインIDまたはパスワードが間違っています"
      end
    end

    def logout
      reset_session_expires
      redirect_to front_login_path
    end
    def authenticate!
      @current_user = User.alive_record({id: session[:current_user_id]})
      return redirect_to front_logout_path unless @current_user
      @current_user.update_column(:logged_in_at, Time.now)

      @current_shop = Shop.alive_record({id: session[:current_shop_id]})
      @current_company = Company.alive_record({id: session[:current_company_id]})

      @mode_staff = @current_user.company_staff? && !@current_user.shop_role.super?
    end

    def has_role?
      #画面要素取得
      @form_write = @form_read = true
      # if Form.master_action?(params)
      #   @form_write = @form_read = true
      # else
      # @current_form = @current_user.find_form(controller_name)
      #   if @current_form
      #     @form_read = @current_form.readable?(@current_user)
      #     @form_write = @current_form.writeble?(@current_user)
      #   end
      # end
    end

    # 自動ログアウトする場合
    def reset_session_expires
      session[:current_user_id] = nil
    end

    def auth_basic
      if AUTH_BASIC_CONFIG[:front]
        authenticate_or_request_with_http_basic do |user, pass|
          user == AUTH_BASIC_CONFIG[:user] && pass == AUTH_BASIC_CONFIG[:pass]
        end
      end
    end

    def dashboard
    end
    private

    def front_user_params
      params[:user] ? params.require(:user).permit(
        User.permit_params
      ) : {}
    end
  end
end
