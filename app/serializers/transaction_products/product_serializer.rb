module TransactionProducts
  class ProductSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :price,
               :quantity,
               :image_urls,
               :state

    def image_urls
      object.images&.map(&:image_url)
    end
  end
end
