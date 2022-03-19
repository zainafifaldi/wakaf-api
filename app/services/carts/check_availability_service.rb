module Carts
  class CheckAvailabilityService < AppService
    attr_reader :current_user, :cart_ids

    def initialize(current_user, cart_ids)
      @current_user = current_user
      @cart_ids = cart_ids
    end

    def call
      validate_cart_param!

      unavailable_carts = []
      carts.includes(:product).find_each do |cart|
        unavailable_carts.push({
          cart_id: cart.id,
          requested_quantity: cart.quantity,
          covered_quantity: cart.product.stock
        }) unless reduceable?(cart)
      end

      unavailable_carts
    end

    private

    def validate_cart_param!
      raise Carts::Errors::CheckAvailabilityBlank if cart_ids.nil?
      raise Carts::Errors::Empty.new('There is no cart exist') if carts.count == 0
    end

    def carts
      @carts ||= Cart.where(id: cart_ids, user_id: current_user.id).user
    end

    def reduceable?(cart)
      cart.product.stock.to_i >= cart.quantity.to_i
    end
  end
end
