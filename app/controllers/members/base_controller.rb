module Members
  class BaseController < ApplicationController
    layout "members"
    before_action :authenticate!,:has_role? ,except: [:login,:logout]

    def login
      if request.post?
        @current_member = Member.authenticate(member_params)
      elsif request.get?
        return render
      end

      if @current_member
        session[:current_member_id] = @current_member.id
        redirect_to members_root_path, notice: 'ログインしました。'
      else
        flash[:alert] = "メールアドレスまたはパスワードが間違っています"
      end
    end

    def logout
      reset_session_expires
      redirect_to members_login_path
    end
    def authenticate!
      @current_member = Member.alive_record({id: session[:current_member_id]})
      return redirect_to members_logout_path unless @current_member
      @current_member.update_column(:last_logined_at, Time.now)
    end

    def has_role?
      # TODO: 画面要素取得
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
      session[:current_member_id] = nil
    end

    def auth_basic
      if AUTH_BASIC_CONFIG[:members]
        authenticate_or_request_with_http_basic do |member, pass|
          member == AUTH_BASIC_CONFIG[:user] && pass == AUTH_BASIC_CONFIG[:pass]
        end
      end
    end

    def dashboard
    end

    private
    def member_params
      params[:member] ? params.require(:member).permit(
        Member.permit_params
      ) : {}
    end
  end
end
