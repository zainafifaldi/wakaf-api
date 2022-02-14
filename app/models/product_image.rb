class ProductImage < ApplicationRecord
  default_scope { order(order: :asc) }
end
