class VideoChannelDecorator < ApplicationDecorator
  class << self
    def required_codes
      %i[video_genre_id tag_names title URL]
    end

    def header_objects
      model = eval(self.model_name.name.camelize)
      [
        model.human(:video_genre_id),
        model.human(:tag_name),
        model.human(:title),
        model.human(:updated_at),
        model.human(:attachment)
      ]
    end

    def body_objects
      [
        'video_genre_id',
        'tag_names',
        'title',
        'strftime_at(:updated_at)',
      ]
    end

    def form_objects(f)
      [
        [
          init_form(f,
                    { code: :video_genre_id, input: f.select(:video_genre_id, class: f.object.decorate.input_class(:video_genre_id, :admin), ジャンルを選択: ''),
                      col: 2 }),
        ],[ 
          init_form(f,
                    { code: :tag_name, input: f.select(:tag_name, class: f.object.decorate.input_class(:tag_name, :admin), タグを選択: ''),
                      col: 1 }),
        ],[
          init_form(f,
                    { code: :title, input: f.text_field(:title, class: f.object.decorate.input_class(:title, :admin), placeholder: '', maxlength: 28),
                      col: 3 }),
        ],[
          init_form(f,
                    { code: :URL, input: f.text_area(:URL, class: f.object.decorate.input_class(:URL, :admin), placeholder: ''),
                      style: { width: "100%" }}),
        ],[
          init_form(f,
                    { code: :explanation, input: f.text_area(:explanation, class: f.object.decorate.input_class(:expanation, :admin), placeholder: ''),
                      style: { width: "100%" }}),
        ],[
          init_form(f,
                    {code: :attachment,input: f.file_field(:attachment),
                      col: 3})
        ],
      ]
    end

    def admin_query_form_objects(f)
      [
        [
          init_form(f, { code: :video_genre_id, input: f.text_field(:video_genre_id, class: input_class), col: 2 }),

          init_form(f, { code: :tag_name, input: f.text_field(:tag_name, class: input_class), col: 3 }),
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

    def tag_names
      object.video_tags.pluck(:tag_name).join(', ')
    end

  end
end