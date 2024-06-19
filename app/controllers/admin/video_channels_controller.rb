module Admin
  class VideoChannelsController < ::Admin::MasterSearchController
    def create
      obj = _model_.new(video_channel_params)
      if obj.save
        update_video_tags(obj)  # VideoTagの処理を追加するメソッド
        flash[:notice] = '登録いたしました'
        redirect_to __send__("admin_#{name_pluralize}_path")
      else
        flash.now[:alert] = '登録に失敗しました'
        render action: :new
      end
    end

    private

    def video_channel_params
      params.require(:video_channel).permit(:video_genre_id, :title, :URL, :explanation)
    end

    # VideoTagを更新するためのメソッド
    def update_video_tags(video_channel)
      tag_names = params[:video_channel][:tag_name].split(',')
      tags = tag_names.map { |name| VideoTag.find_or_create_by(tag_name: name.strip) }
      video_channel.video_tags = tags
    end
  end
end
