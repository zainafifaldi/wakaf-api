module ProductImages
  class IndexService < ApplicationService
    attr_reader :product_id

    def initialize(product_id)
      @product_id = product_id
    end

    def call
      @product_images = ProductImage.where(product_id: product_id)
      @product_images.all
    end
  end
end
