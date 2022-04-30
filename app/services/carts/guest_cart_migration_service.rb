module Carts
  class GuestCartMigrationService < AppService
    attr_reader :current_guest, :current_user

    def initialize(current_guest, current_user)
      @current_guest = current_guest
      @current_user = current_user
    end

    def call
      result = Carts::IndexService.call(current_guest, {})

      result[:carts].each do |cart|
        migrate_cart(cart)
      end
    end

    private

    def migrate_cart(cart)
      existing_cart = current_product_in_cart(cart.product_id)

      cart.update_attributes!(
        user_id: current_user.id,
        reference: 'user'
      )

      remove_resource(existing_cart) if existing_cart.present?
    end

    def current_product_in_cart(product_id)
      Cart.where(reference: 'user', user_id: current_user.id, product_id: product_id).first
    end

    def remove_resource(cart)
      cart.destroy!
    end
  end
end
