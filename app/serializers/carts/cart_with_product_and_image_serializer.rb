module Carts
  class CartWithProductAndImageSerializer < ActiveModel::Serializer
    attributes :id,
               :quantity,
               :product,
               :created_at,
               :updated_at

    has_one :product, serializer: Products::ProductWithImageSerializer

    def product
      object.product
    end
  end
end