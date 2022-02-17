class ProductImage < ApplicationRecord
  default_scope { order(order: :asc) }

  belongs_to :product, class_name: 'Product'
end
