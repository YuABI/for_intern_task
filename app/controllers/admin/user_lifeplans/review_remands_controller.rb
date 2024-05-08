module Admin
  module UserLifeplans
    class ReviewRemandsController < Admin::MasterController
      before_action :set_user_lifeplan, only: %i[update]

      def update
        if @user_lifeplan.remand_review
          redirect_to admin_user_lifeplans_url(@user_lifeplan), notice: t('flash_messages.update_successed')

        else
          redirect_to admin_user_lifeplans_url(@user_lifeplan), notice: t('flash_messages.update_failed')
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
        @user_lifeplan = UserLifeplan.find(params[:user_lifeplan_id])
      end

      def params_id
        params[:user_lifeplan_id]
      end
    end
  end
end
