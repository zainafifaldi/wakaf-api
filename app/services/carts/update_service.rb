module Carts
  class UpdateService < AppService
    attr_reader :cart, :params

    def initialize(cart, params)
      @cart = cart
      @params = params
    end

    def call
      @cart.update_attributes!(
        quantity: params[:quantity]
      )
    end
  end
end
