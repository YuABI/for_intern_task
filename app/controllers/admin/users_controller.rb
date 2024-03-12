module Admin
  class UsersController < ::Admin::MasterSearchController
    def new
      super
      @user.user_address_setup
    end

    def add_associations(**args)
      obj = find_or_initialize_object
      obj.assign_attributes(admin_object_params)
      association_model = args[:association_model]

      render_javascript do |page|
        obj.send(association_model).build
        page.replace_html('form', partial: 'form')
      end
    rescue StandardError => e
      LoggerService.new(exception: e, request:).call
    end

    def del_associations(**args)
      obj = find_or_initialize_object
      association_model = args[:association_model]

      options = admin_object_params

      options[:"#{association_model}_attributes"][params[:target_idx]][:_destroy] = '1'

      obj.assign_attributes(options)
      render_javascript do |page|
        page.replace_html('form', partial: 'form')
      end
    rescue StandardError => e
      LoggerService.new(exception: e, request:).call
    end

    def add_address
      add_associations(association_model: :addresses)
    end

    def del_address
      del_associations(association_model: :addresses)
    end

    def add_user_inquiry
      add_associations(association_model: :user_inquiries)
    end

    def del_user_inquiry
      del_associations(association_model: :user_inquiries)
    end
  end
end
