class ProductImagesController < ApplicationController
  def index
    product_images = ProductImages::IndexService.call(params[:product_id])

    render json: product_images
  end
end
