module Products
  class ShowService < AppService
    attr_reader :product_id

    def initialize(product_id)
      @product_id = product_id
    end

    def call
      Product.find(product_id)
    end
  end
end
