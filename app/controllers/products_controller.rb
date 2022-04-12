class ProductsController < ApplicationController
  def index
    result = Products::IndexService.call(index_params)

    meta_options = {
      page:     (result[:page] || 1),
      per_page: result[:per_page],
      total:    result[:total]
    }

    render_serializer result[:products].to_a, Products::ProductWithImageSerializer, { meta: meta_options }
  end

  def show
    product = Products::ShowService.call(params[:id])

    render_serializer product, Products::ProductSerializer
  rescue ActiveRecord::RecordNotFound
    render_error 'Product Not Found', meta: { http_status: :not_found }
  end

  private

  def index_params
    params.permit(:page, :per_page, :query, :sort)
  end
end
