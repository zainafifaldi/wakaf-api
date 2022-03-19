module TransactionProducts
  class CreateFromCartService < AppService
    attr_reader :current_user, :transaction, :cart_ids

    def initialize(current_user, transaction, cart_ids)
      @current_user = current_user
      @transaction = transaction
      @cart_ids = cart_ids
    end

    def call
      Cart.where(id: cart_ids, user_id: current_user.id).user.includes(:product).find_each do |cart|
        transaction.products.create!(
          product_id: cart.product_id,
          name: cart.product.name,
          price: cart.product.price,
          quantity: cart.quantity
        )

        reduce_stock(cart.product_id, cart.quantity)
      end

      transaction
    end

    private

    def reduce_stock(product_id, quantity)
      product = Product.find(product_id)
      product.stock = product.stock.to_i - quantity.to_i
      product.save!
    end
  end
end
