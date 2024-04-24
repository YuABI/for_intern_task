module Front
  class PageController < Front::BaseController
    include Pages::ContentControlAction
    def search_content_control
      @query = ContentControlQuery.new(content_control_params.merge(shop_id: @current_shop.id))
      @content_controls = @query.call(load_condition: false, paginate: {page: params[:page], per: params[:par], order: params[:order]}, user: @current_user)

      render_javascript do |page|
        page.replace_html("object_lists", partial: "object_lists", locals: {mode: params[:mode]})
      end
    rescue StandardError => e
      LoggerService.new(exception: e,request: request).call
    end
    def kondate
      set_query
    end

    def kondate_detail
      set_content_control
    end

    def shokuiku
      set_query
    end

    def shokuiku_detail
      set_content_control
    end

    def other
      set_query
    end

    def other_detail
      set_content_control
    end

    def faq
      set_query
    end

    def faq_detail
      set_content_control
    end

    def content_doc_download
      content_control = ContentControl.find_by(id: params[:content_control_id])
      content_doc = content_control.content_docs.find_by(id: params[:content_doc_id])

      _doc = content_doc ? content_doc : content_control
      unless @current_user.all_company?
        content_doc_download = content_control.content_doc_downloads.build(
          company_id:     @current_company.id,
          shop_id:        @current_shop.id,
          user_id:        @current_user.id,
          content_doc_id: content_doc.try(:id).to_i,
          title:          CGI.unescape(File.basename(_doc.doc.url)),
          downloaded_at:  Time.now,

          )
        content_doc_download.save!
      end

      redirect_to(_doc.doc.url, allow_other_host: true)
    end

    def news
      render Front::NoticeBoards::Component.new(shop: @current_shop,user: @current_user)
    end

    def news_detail
      @notice_boards = NoticeBoard.all_select.where(company_id: [@current_company.id.to_i,0])
      @notice_board = @notice_boards.custom_find_by(id: params[:code]) rescue nil
    end

    def auto_alert
      if @alert_mode_h.keys.include?("show_day_alert")
        today =  User.alert_date
        case today.wday
        when User.alert1_day
          @current_user.alert1_date = today
        when User.alert2_day
          @current_user.alert2_date = today
        when User.alert3_day
          @current_user.alert3_date = today
        when User.alert4_day
          @current_user.alert4_date = today
        when User.alert5_day
          @current_user.alert5_date = today
        when User.alert6_day
          @current_user.alert6_date = today
        when User.alert0_day
          @current_user.alert0_date = today
        end
        @current_user.save(validate: false)
      end

      render layout: false if request.xhr?
    rescue StandardError => e
      LoggerService.new(exception: e,request: request).call
    end

    def check_notice_board
      @notice_board = NoticeBoard.custom_find_by({id: params[:id]})
      notice_board_user = NoticeBoardUser.read_notice(@current_user,@notice_board)
      if notice_board_user
        notice_board_user.destroy
      else
        NoticeBoardUser.new(
          user_id:         @current_user.id,
          notice_board_id: @notice_board.id
        ).save!

      end
    end

    def survey_detail
      @survey_control = @survey_controls.custom_find_by(id: params[:code]) rescue nil
    end

    def my_page
      unless request.get?
        @current_shop.attributes = front_shop_params
        if @current_shop.save(context: :my_page)
          flash[:notice] = "更新いたしました"
        else
          flash.now[:alert] = "更新に失敗しました"
        end
      end
    end

    def contact

    end

    private

    def front_shop_params
      return {} unless params[:shop]
      params.require(:shop).permit(
        Shop.permit_params
      )
    end

  end
end
