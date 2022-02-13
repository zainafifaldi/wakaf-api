class ProductsController < ApplicationController
  def index
    products = Products::IndexService.call(index_params)

    render json: products, each_serializer: Products::ProductWithImageSerializer
  end

  def show
    product = Products::ShowService.call(params[:id])

    render json: product, serializer: Products::ProductSerializer
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Product Not Found' }, status: :not_found
  end

  private

  def index_params
    params.permit(:page, :per_page, :query, :sort)
  end
end
