module Front
  module BaseHelper
    def image_logo(options = {})
      options[:height] ||= 33
      options[:width] ||= "180px"
      image_tag(image_logo_path,options)
    end
    def image_logo_path
      "admin/logo.svg"
    end
    def image_top_logo(options = {})
      options[:height] ||= 33
      image_tag(image_top_logo_path,options)
    end
    def image_top_logo_path
      "base/rakushigo-logo.png"
    end
    def image_header_logo(options = {})
      options[:height] ||= 33
      image_tag(image_header_logo_path,options)
    end
    def image_header_logo_path
      "base/rakushigo-logo.png"
    end
    def image_short_logo(options = {})
      options[:height] ||= 33
      image_tag(image_short_logo_path,options)
    end
    def image_short_logo_path
      "base/favicon.svg"
    end
    def input_group_class
      "input-group-sm"
    end
    def admin_link_btn(name)
      "<button type='button' class='btn btn-sm btn-rounded btn-soft-success'>#{name}</button>".html_safe
    end





  end
end
