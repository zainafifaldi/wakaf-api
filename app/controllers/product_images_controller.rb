class ProductImagesController < ApplicationController
  def index
    product_images = ProductImages::IndexService.call(params[:product_id])

    render_serializer product_images.to_a, ProductImages::ImageSerializer
  end
end
