module Carts
  class RemoveFromCartService < AppService
    attr_reader :cart

    def initialize(cart)
      @cart = cart
    end

    def call
      @cart.destroy!
    end
  end
end
