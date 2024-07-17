class VideoTagDecorator < ApplicationDecorator
    class << self
      def required_codes
        %i[tag_name]
      end
  
      def header_objects
        model = eval(self.model_name.name.camelize)
        [
          model.human(:id),
          model.human(:tag_name),
        ]
      end
  
      def body_objects
        [
          'id',
          'tag_name',
      #    'email',
      #    'strftime_at(:last_logined_at)',
        ]
      end
  
      def form_objects(f)
        [
          [
            init_form(f,
                      { code: :tag_name, input: f.text_field(:tag_name, class: f.object.decorate.input_class(:tag_name, :admin), placeholder: ''),
                        col: 3 }),
          ],
        ]
      end
  

      def admin_query_form_objects(f)
        [
          [
            init_form(f, { code: :tag_name, input: f.text_field(:tag_name, class: input_class), col: 4 }),
          ]
        ]
      end
    end
  end
  