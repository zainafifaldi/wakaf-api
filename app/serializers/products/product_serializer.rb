module Products
  class ProductSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :price,
               :description,
               :stock,
               :sold_count,
               :created_at,
               :updated_at
  end
end
