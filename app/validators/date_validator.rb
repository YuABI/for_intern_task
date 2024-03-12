class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.is_a?(Date)
      record.errors[attribute] << (options[:message] || 'is not a valid date')
    end
  end
end
