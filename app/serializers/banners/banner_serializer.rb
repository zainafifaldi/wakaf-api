module Banners
  class BannerSerializer < ActiveModel::Serializer
    attributes :id,
               :image_url,
               :order,
               :created_at,
               :updated_at
  end
end
