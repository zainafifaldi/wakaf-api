module Carts
  class AddToCartService < AppService
    attr_reader :current_user_or_guest, :params

    def initialize(current_user_or_guest, params)
      @current_user_or_guest = current_user_or_guest
      @params = params
    end

    def call
      validate_product!

      cart.present? ? update_cart : insert_cart
    end

    private

    def validate_product!
      raise Products::Errors::NotFound unless product.present?
    end

    def product
      @product ||= Product.find_by_id(params[:product_id])
    end

    def cart
      @cart ||= cart_by_user_type.where(user_id: current_user_or_guest.id, product_id: params[:product_id]).first
    end

    def cart_by_user_type
      user? ? Cart.user : Cart.guest
    end

    def update_cart
      cart.quantity = cart.quantity + params[:quantity]
      cart.save!
    end

    def insert_cart
      Cart.create!(
        product_id: params[:product_id],
        user_id: current_user_or_guest.id,
        reference: reference,
        quantity: params[:quantity]
      )
    end

    def reference
      current_user_or_guest.class.name.downcase
    end
  end
end
