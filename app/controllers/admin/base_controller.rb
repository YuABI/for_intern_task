module Admin
  class BaseController < ApplicationController
    layout 'admin'
    before_action :authenticate!, :has_role?, except: %i[login logout]

    def login
      return render if request_get_or_head?

      @admin_user = AdminUser.authenticate(admin_admin_user_params)

      if @admin_user
        session[:current_admin_user_id] = @admin_user.id
        redirect_to admin_root_path, notice: 'ログインしました。'
      else
        flash[:alert] = 'ログインコードまたはパスワードが間違っています'
      end
    end

    def logout
      reset_session_expires
      redirect_to admin_login_path
    end

    def authenticate!
      @current_admin_user = AdminUser.alive_record({ id: session[:current_admin_user_id] })
      redirect_to admin_logout_path unless @current_admin_user
    end

    def has_role?
      @current_operation = @current_admin_user.find_operation(controller_name)
      @write_operation = @read_operation = true
      #   if @current_operation
      #     @read_operation = @current_operation.readable?(@current_admin_user)
      #     @write_operation = @current_operation.writeble?(@current_admin_user)
      #   end
      redirect_to admin_root_path, alert: '閲覧権限がありません。' unless @read_operation
    end

    # 自動ログアウトする場合
    def reset_session_expires
      session[:current_admin_user_id] = nil
    end

    def auth_basic
      if AUTH_BASIC_CONFIG[:admin]
        authenticate_or_request_with_http_basic do |user, pass|
          user == AUTH_BASIC_CONFIG[:user] && pass == AUTH_BASIC_CONFIG[:pass]
        end
      end
    end

    def get_file
      # TODO: あとで直す
      file_name = params[:file_name].gsub('/', '').gsub('..', '').gsub('./', '')
      dir       = params[:dir].gsub('~', '').gsub('..', '').gsub('./', '')
      send_file Pathname.new([FileCreateUtil.file_info[:tmp], dir].compact_blank.join('/') + '/' + file_name)
    rescue StandardError => e
      p e
    end

    private

    def admin_admin_user_params
      if params[:admin_user]
        params.require(:admin_user).permit(
          AdminUser.permit_params
        )
      else
        {}
      end
    end
  end
end
