class ApplicationDecorator < Draper::Decorator
  delegate_all
  include HtmlTagHelper
  include SupportDateDecorator
  include SupportTextDecorator

  def html_option
    {}
  end

  def body_style
    ''
  end

  def member_body_style(member)
    body_style
  end

  def admin_body_style
    body_style
  end

  def no_required?(code)
    return false if self.class.required_codes.include?(code.to_sym)

    true
  end

  def required_icon(code, _mode = :front)
    return '' if no_required?(code)

    self.class.required_icon
  end

  def label(code, mode = :front)
    if mode == :front
    end
    yield if block_given?
    self.class.human(code)
  end

  def input_placeholder(_attr, _mode = :front)
    ''
  end

  def input_class(attr, mode = :front)
    _class_name = self.class.input_class
    error_msg = self.generate_error_message(attr)
    if error_msg.present?
      return "#{_class_name} #{self.class.error_class} err_class_#{self.class.model_class_name.downcase}_#{attr}"
    end

    if mode == :front
      _class_name += if self[attr].blank?
                       " #{self.class.before_class}"
                     else
                       " #{self.class.clear_class}"
                     end
    end

    _class_name
  end

  def input_type(attr)
    case attr.to_s
    when 'email', 'email_confirmation' then 'url'
    when 'tel', 'zip' then 'tel'
    # when "birthday","date","ec_arrival_date" ;"date"
    else; 'text'
    end
  end

  def error_message_html(attr, mode = :front)
    error_msg    = self.generate_error_message(attr)
    error_msg_id = "hint_#{self.class.table_name.singularize}_#{attr}"
    return "<span id='#{error_msg_id}'></span>".html_safe if error_msg.blank?

    self.class.error_message_html(error_msg.to_s, { mode:, css_id: error_msg_id })
  end

  class << self
    def model_name_human(sym)
      I18n.t("activerecord.models.#{sym.to_s.downcase}")
    end

    def model_class_name
      name.gsub('Decorator', '')
    end

    def allow_new?
      true
    end

    def check_box_ele(_check_box, opt = {})
      opt[:style] = 'width: 100%;' if opt[:style].blank?
      _ele = <<-HTML
      <div class="form-check">
         #{_check_box}
          <label class="form-check-label#{opt[:class]}" style="#{opt[:style]} for="formCheck2">
              #{opt[:name]}
          </label>
      </div>
      HTML
      _ele.html_safe
    end

    def input_class
      'form-control'
    end

    def error_message_html(error_msg, options = {})
      html = <<~HTML
        <span class="invalid-message" id="#{options[:css_id]}">
           #{error_msg}
        </span>
      HTML
      html.html_safe
    end

    def required_codes
      []
    end

    def required_icon(title = '必須')
      html = <<~HTML
        <span class="required-icon">#{title}</span>
      HTML
      html.html_safe
    end

    def error_class = 'error'
    def success_class = 'success'
    def clear_class = 'clear'
    def before_class = 'before'

    def init_form(f, opt, _label_display = true)
      error_msg = f.object.errors.full_messages_for(opt[:code]).join('<br/>')
      if error_msg.present?
        # opt[:row_class] = err_class
        # opt[:error_msg] = "#{err_html(error_msg)}".html_safe
      end
      if opt[:label].blank? && !f.object.is_a?(ApplicationQuery)
        opt[:label] = f.object.decorate.label(opt[:code], :admin)
      end
      opt
    end

    def header_style
      {}
    end

    def header_objects
      model = eval(self.model_name.name.camelize)
      [
        model.human(:id),
      ]
    end

    def member_header_objects(member)
      header_objects
    end

    def body_style
      {}
    end

    def member_body_style(member)
      body_style
    end

    def body_objects
      [
        'id',
      ]
    end

    def member_body_objects(member)
      body_objects
    end

    def show_objects(_admin_user, obj)
      [
        [
          { code: :id, value: obj.id, col: 6 },
        ],
      ]
    end

    def form_objects(f)
      [
        [
          init_form(f,
                    { code: :name, input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin), placeholder: ''),
                      col: 6, no_required: false, help: '', alert: '' }),
        ],
        [
          init_form(f,
                    { code: :code, input: f.text_field(:code, class: f.object.decorate.input_class(:code, :admin), placeholder: ''),
                      col: 6, no_required: false, help: '', alert: '' }),
        ],

      ]
    end

    def form_javascript(_f)
      html = <<~HTML
        $('.select2').select2({
          closeOnSelect: true,
          dropdownAutoWidth: false,
          width: "resolve"
        });
      HTML

      html.html_safe
    end

    def admin_query_form_objects(f)
      [
        [
          init_form(f, { code: :name, input: f.text_field(:name, class: input_class), col: 4 }),
        ],
      ]
    end

    def action_links(_admin_user, object, write_form)
      links = []
      _exist  = object.exists_db?
      links << (if write_form && _exist && object.allow_edit?
                  h.link_to('修正', h.__send__("edit_admin_#{object.class.table_name.singularize}_path", object),
                            object.html_option.merge(class: "btn btn-sm btn-#{h.color_edit}"))
                else
                  '-'
                end)

      links << (if write_form && _exist && object.allow_delete?
                  h.link_to('削除', h.__send__("admin_#{object.class.table_name.singularize}_path", object), method: :delete,
                                                                                                           data: { confirm: '本当に削除しますか？' }, class:  "btn btn-sm btn-#{h.color_destroy}")
                else
                  '-'
                end)
      links
    end

    def member_action_links(member, object, write_form)
      links = []
      _exist  = object.exists_db?
      links << (if write_form && _exist && object.allow_edit?
                  h.link_to('修正', h.__send__("edit_members_#{object.class.table_name.singularize}_path", object),
                            object.html_option.merge(class: "btn btn-sm btn-#{h.color_edit}"))
                else
                  '-'
                end)

      links << (if write_form && _exist && object.allow_delete?
                  h.link_to('削除', h.__send__("members_#{object.class.table_name.singularize}_path", object), method: :delete,
                            data: { confirm: '本当に削除しますか？' }, class:  "btn btn-sm btn-#{h.color_destroy}")
                else
                  '-'
                end)
      links
    end

    def admin_csv_export?
      false
    end

    def admin_csv_import?
      false
    end
  end
end
