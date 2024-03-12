module SupportPolymorphicDecorator
  extend ActiveSupport::Concern
  def target_type_human
    self.class.model_name_human(target_type)
  end

  def target_human
    "#{target_type_human}ID：#{target_id}"
  end
  class_methods do
  end
end
