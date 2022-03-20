module Carts
  class IndexService < AppService
    include PaginatableResources

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

      total = @carts.count

      @carts = set_pagination(@carts, params) unless ids_selected?

      {
        carts:    @carts.includes(product: [:images]).all,
        page:     @page,
        per_page: @per_page,
        total:    total
      }
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
  end
end
