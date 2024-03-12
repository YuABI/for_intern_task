module Admin
  class ApiClientsController < ::Admin::MasterSearchController
    def api_key
      redirect_to(__send__("admin_#{name_pluralize}_path")) unless find_object
    end
  end
end
