module JavascriptResponseBuilder
  def render_javascript
    context = PageContext.new
    context.controller = self
    yield(context)
    response['Content-Type'] = response.content_type = 'text/javascript; charset=utf-8'
    render plain: context.code, layout: false
  end

  class PageContext
    include ActionView::Helpers::JavaScriptHelper

    attr_reader :code
    attr_writer :controller

    def initialize
      @code = ''
    end

    def replace_html(id, html)
      html = @controller.render_to_string(html) if html.is_a?(Hash)
      @code << "jQuery('##{id}').html('#{escape_javascript html}');"
    end

    def after_html(id, html)
      html = @controller.render_to_string(html) if html.is_a?(Hash)
      @code << "jQuery('##{id}').after('#{escape_javascript html}');"
    end

    def redirect_to(url)
      url = @controller.url_for(url) if url.is_a?(Hash)
      @code << "window.location.href = '#{escape_javascript url}';"
    end

    def show(id)
      @code << "jQuery('##{id}').show();"
    end

    def hide(id)
      @code << "jQuery('##{id}').hide();"
    end

    def remove_html(id)
      @code << "jQuery('##{id}').remove();"
    end

    def alert(str, opt = {})
      # @code << "alert('#{str}');"
      @code << "swal('#{str}','#{opt[:sub]}','#{opt[:mode]}');"
    end

    def anchor(id, offset = 150, speed = 500)
      @code << "jQuery(\"html, body\").animate({scrollTop: jQuery(\"##{id}\").offset().top - #{offset}}, #{speed}, \"swing\");"
    end

    def script(script)
      @code << "#{script};"
    end

    def scroll(id_ = nil, adjust = 0)
      id_ = id_ ? "##{id_}" : 'html'
      @code <<  <<-HTML
      jQuery("body,html").animate({scrollTop: jQuery("#{id_}").offset().top + #{adjust}}, 400, "swing");
      HTML
    end

    def send_file(**args)
      dir       = args[:dir]
      file_name = args[:file_name]
      @code << "window.location.href = '#{escape_javascript("/admin/get_file?file_name=#{file_name}&dir=#{dir}")}';"
    end
  end
end
