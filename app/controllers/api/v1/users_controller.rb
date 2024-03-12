module Api
  module V1
    class UsersController < Api::V1::BaseController
      def create_addresses
        create_associations(object: find_object, association_model: :address,
                            change_history_code: :api_user_address_create)
      end

      def update_addresses
        update_associations(object: find_object, association_model: :address,
                            change_history_code: :api_user_address_update)
      end

      def login
        return render_bad_request('invalid params') if api_login_params.blank?

        user = User.authenticate(api_login_params)
        return render_bad_request("email: #{api_login_params[:email]}  not found") unless user

        render_json(user.to_api_wrapper, { include: include_options })
      end

      protected

      def include_options
        %i[addresses user_inquiries]
      end

      def api_login_params
        return {} unless params[:"#{name_singularize}"]

        params.require(:"#{name_singularize}").permit(
          %i[email password]
        )
      end
    end
  end
end
