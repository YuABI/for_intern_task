class VideoChannelDecorator < ApplicationDecorator
  class << self
    def required_codes
      %i[video_genre_id video_tags_id title URL]
    end

    def header_objects
      model = eval(self.model_name.name.camelize)
      [
        model.human(:video_genre_id),
        model.human(:name),
        model.human(:title),
        model.human(:updated_at)
      ]
    end

    def body_objects
      [
        'video_genre_id',
        'name',
        'title',
        'strftime_at(:updated_at)',
      ]
    end

    def form_objects(f)
      [
        [
          init_form(f,
                    { code: :video_genre_id, input: f.text_field(:video_genre_id, class: f.object.decorate.input_class(:video_genre_id, :admin), placeholder: ''),
                      col: 2 }),
          init_form(f,
                    { code: :name, input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin), placeholder: ''),
                      col: 3 }),
          init_form(f,
                    { code: :title, input: f.text_field(:title, class: f.object.decorate.input_class(:title, :admin), placeholder: ''),
                      col: 3 }),
          init_form(f,
                    { code: :URL, input: f.text_area(:URL, class: f.object.decorate.input_class(:URL, :admin), placeholder: ''),
                      style: { width: "100%" }}),
          init_form(f,
                    { code: :explanation, input: f.text_area(:explanation, class: f.object.decorate.input_class(:expanation, :admin), placeholder: ''),
                      style: { width: "100%" }}),
          init_form(f,
                    {code: :attachment,input: f.file_field(:attachment, multiple: true),
                      col: 3})
        ],
      ]
    end

    def admin_query_form_objects(f)
      [
        [
          init_form(f, { code: :video_genre_id, input: f.text_field(:video_genre_id, class: input_class), col: 2 }),
          init_form(f, { code: :name, input: f.text_field(:name, class: input_class), col: 3 }),
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
end