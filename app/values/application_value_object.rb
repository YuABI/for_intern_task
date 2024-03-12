class ApplicationValueObject
  include ActiveModel::Model
  include ActiveModel::Attributes

  def to_hash
    attributes
  end
end
