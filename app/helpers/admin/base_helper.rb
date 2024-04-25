module Admin
  module BaseHelper
    def image_logo(options = {})
      options[:height] ||= 33
      options[:width] ||= "180px"
      image_tag('admin/logo.svg', options)
    end

    def input_group_class
      'input-group-sm'
    end

    def admin_link_btn(name)
      "<button type='button' class='btn btn-sm btn-rounded btn-soft-success'>#{name}</button>".html_safe
    end
  end
end
