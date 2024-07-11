class VideoGenreDecorator < ApplicationDecorator
    class << self
      def required_codes
        %i[name]
      end
  
      def header_objects
        model = eval(self.model_name.name.camelize)
        [
          model.human(:id),
          model.human(:name),
        ]
      end
  
      def body_objects
        [
          'id',
          'name',
        ]
      end
  
      def form_objects(f)
        [
          [
            init_form(f,
                      { code: :name, input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin), placeholder: ''),
                        col: 3 }),
          ],
        ]
      end
  

    end
  end
  