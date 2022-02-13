module Products
  class ProductWithImageSerializer < ActiveModel::Serializer
    attributes :name,
               :price,
               :description,
               :stock,
               :sold_count,
               :image,
               :created_at,
               :updated_at

    has_one :image, serializer: ProductImages::ImageSerializer

    def image
      object.images.first
    end
  end
end