module Products
  class IndexService < AppService
    MAX_PER_PAGE = 20

    include PaginatableResources

    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      @products = Product.active
      @products = @products.where('name LIKE ?', "%#{params[:query]}%") if params[:query].present?
      @products = order_products
      @products = set_pagination(@products, params)

      {
        products: @products.includes(:images).all,
        page:     @page,
        per_page: @per_page,
        total:    total
      }
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
