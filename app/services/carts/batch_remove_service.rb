module Carts
  class BatchRemoveService < AppService
    attr_reader :current_user, :cart_ids

    def initialize(current_user, cart_ids)
      @current_user = current_user
      @cart_ids = cart_ids
    end

    def call
      Cart.where(id: cart_ids, user_id: current_user.id).user.find_each do |cart|
        cart.destroy!
      end
    end
  end
end
