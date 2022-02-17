class Product < ApplicationRecord
  has_many :images, class_name: 'ProductImage'
  has_many :carts, class_name: 'Cart'

  scope :active, -> { where(active: true) }
end
