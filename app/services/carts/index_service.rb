module Carts
  class IndexService < AppService
    attr_reader :current_user_or_guest, :params

    def initialize(current_user_or_guest, params)
      @current_user_or_guest = current_user_or_guest
      @params = params
    end

    def call
      @carts = carts_by_user_type
      @carts = @carts.where(user_id: current_user_or_guest.id)
      @carts = @carts.where(id: selected_ids) if ids_selected?
      @carts = @carts.order(updated_at: :desc)

      set_pagination unless ids_selected?

      @carts.includes(product: [:images]).all
    end

    private

    def ids_selected?
      params[:selected_ids].present?
    end

    def selected_ids
      params[:selected_ids].map(&:to_i)
    end

    def carts_by_user_type
      user? ? Cart.user : Cart.guest
    end

    def set_pagination
      @carts = @carts.limit(params[:per_page].to_i) if params[:per_page].present?
      @carts = @carts.offset((params[:page].to_i - 1) * params[:per_page].to_i) if params[:page].present?
    end
  end
end
