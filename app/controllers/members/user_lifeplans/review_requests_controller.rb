module Members
  module UserLifeplans
    class ReviewRequestsController < Members::MasterController
      before_action :set_user_lifeplan, only: %i[update]

      def update
        if @user_lifeplan.request_review
          redirect_to members_user_lifeplan_url(@user_lifeplan),
                      notice: t('flash_messages.update_successed')

        else
          redirect_to members_user_lifeplan_url(@user_lifeplan),
                      notice: t('flash_messages.update_failed')
        end
      end

      private

      def name_singularize
        'user_lifeplan'
      end

      def name_pluralize
        name_singularize.pluralize
      end

      def set_user_lifeplan
        @user_lifeplan = find_object
      end

      def params_id
        params[:user_lifeplan_id]
      end
    end
  end
end
