module ProductImages
  class ImageSerializer < ActiveModel::Serializer
    attributes :product_id,
               :image_url,
               :order,
               :created_at,
               :updated_at
  end
end
