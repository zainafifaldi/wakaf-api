module Products
  class IndexService < ApplicationService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      @products = Product.active.includes(:images)
      @products = @products.where('name LIKE ?', "%#{params[:query]}%") if params[:query].present?
      @products = order_products
      @products = @products.limit(params[:per_page].to_i) if params[:per_page].present?
      @products = @products.offset((params[:page].to_i - 1) * params[:per_page].to_i) if params[:page].present?
      @products.all
    end

    private

    def order_products
      @products = @products.order('stock = 0')

      params[:sort] = 'newest' unless params[:sort].present?

      case params[:sort]
      when 'newest'
        @products.order(created_at: :desc)
      when 'oldest'
        @products.order(created_at: :asc)
      when 'price_lowest'
        @products.order(price: :asc)
      when 'price_highest'
        @products.order(price: :desc)
      when 'most_popular'
        @products.order(sold_count: :desc)
      when 'least_popular'
        @products.order(sold_count: :asc)
      end
    end
  end
end
