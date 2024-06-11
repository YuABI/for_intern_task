class ProductCategory < ApplicationRecord

  has_many :product_options

  validates :name, :code, presence: true
end
