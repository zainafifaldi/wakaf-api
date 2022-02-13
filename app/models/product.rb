class Product < ApplicationRecord
  has_many :images, class_name: 'ProductImage'

  scope :active, -> { where(active: true) }
end
