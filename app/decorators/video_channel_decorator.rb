class VideoChannelDecorator < ApplicationDecorator
  delegate_all
  
  class << self
    def required_codes
      %i[name tag_names title URL setting]
    end

    def header_objects
      model = eval(self.model_name.name.camelize)
      [
        model.human_attribute_name(:name),
        model.human_attribute_name(:tag_names),
        model.human_attribute_name(:title),
        model.human_attribute_name(:updated_at),
        model.human_attribute_name(:setting),
      ]
    end

    def body_objects
      [
        'name',
        'tag_names',
        'title',
        'strftime_at(:updated_at)',
        'setting',
      ]
    end

    def form_objects(f)
      video_genre_options = VideoGenre.pluck(:name, :id)
      video_tag_options = VideoTag.pluck(:tag_name, :id)
      video_publish_setting_options = VideoPublishSetting.pluck(:setting, :id)
      [
        [
          init_form(f,
                    { code: :name, input: f.select(:video_genre_id, video_genre_options, { include_blank: 'ジャンル名を選択' }, class: f.object.decorate.input_class(:video_genre_id, :admin)),
                      col: 2 }),
        ], [
          init_form(f,
                    { code: :tag_names, input: f.select(:tag_ids, video_tag_options, { include_blank: 'タグ名を選択', multiple: true }, class: f.object.decorate.input_class(:tag_ids, :admin)),
                      col: 2 }),
        ], [
          init_form(f,
                    { code: :title, input: f.text_field(:title, class: f.object.decorate.input_class(:title, :admin), placeholder: '', maxlength: 28),
                      col: 3 }),
        ], [
          init_form(f,
                    { code: :URL, input: f.text_area(:URL, class: f.object.decorate.input_class(:URL, :admin), placeholder: ''),
                      style: { width: "100%" }}),
        ], [
          init_form(f,
                    { code: :setting, input: f.select(:video_publish_setting_id, video_publish_setting_options, { include_blank: '公開/非公開を選択' }, class: f.object.decorate.input_class(:video_publish_setting_id, :admin)),
                      col: 2 }),
        ], [
          init_form(f,
                    { code: :explanation, input: f.text_area(:explanation, class: f.object.decorate.input_class(:explanation, :admin), placeholder: ''),
                      style: { width: "100%" }}),
        ], 
      ]
    end

    def admin_query_form_objects(f)
      video_genre_options = VideoGenre.pluck(:name, :id)
      video_tag_options = VideoTag.pluck(:tag_name, :id)
      video_publish_setting_options = VideoPublishSetting.pluck(:setting, :id)
      [
        [
          init_form(f, { code: :name, input: f.select(:video_genre_id, video_genre_options, { include_blank: 'ジャンル名を選択' }, class: input_class), col: 2 }),

          init_form(f, { code: :tag_names, input: f.select(:tag_ids, video_tag_options, { include_blank: 'タグ名を選択', multiple: true }, class: input_class), col: 3 }),

          init_form(f, { code: :setting, input: f.select(:video_publish_setting_id, video_publish_setting_options, { include_blank: '公開設定を選択' }, class: input_class), col: 3 }),
        ], [
          init_form(f,
                    { code: :updated_at_from,
                      input: f.text_field(:updated_at_from, type: :date, class: input_class), col: 3 }),
          init_form(f,
                    { code: :updated_at_to,
                      input: f.text_field(:updated_at_to, type: :date, class: input_class), col: 3 }),
        ]
      ]
    end
  end

  def name
    object.video_genre&.name
  end

  def tag_names
    object.video_tags.pluck(:tag_name).join(", ")
  end

  def setting
    object.video_publish_setting&.setting
  end
 
end
