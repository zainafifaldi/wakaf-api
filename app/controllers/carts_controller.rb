class CartsController < ApplicationController
  before_action :authorize_user_or_guest
  before_action :validate_resource!, only: [:update, :destroy]

  rescue_from ActiveRecord::RecordNotFound do
    render_error 'Cart not found', { meta: { http_status: :not_found } }
  end

  def index
    result = Carts::IndexService.call(current_user_or_guest, index_params)

    meta_options = { total: result[:total] }
    meta_options[:page] = (result[:page] || 1) if result[:per_page].present?
    meta_options[:per_page] = result[:per_page] if result[:per_page].present?

    render_serializer result[:carts].to_a, Carts::CartWithProductAndImageSerializer, { meta: meta_options }
  end

  def create
    Carts::AddToCartService.call(current_user_or_guest, create_params)

    render_message 'Product added to cart successfuly', { meta: { http_status: :created } }
  end

  def update
    Carts::UpdateService.call(current_resource, update_params)

    render_message 'Cart updated successfuly'
  end

  def destroy
    Carts::RemoveFromCartService.call(current_resource)

    render_message 'Product removed from cart successfuly'
  end

  private

  def validate_resource!
    render_error('Forbidden access to resource', { meta: { http_status: :forbidden } }) unless resource_owner?
  end

  def resource_owner?
    current_resource.reference == current_user_or_guest.class.name.downcase &&
    current_resource.user_id == current_user_or_guest.id
  end

  def current_resource
    @current_resource ||= Cart.find(params[:id])
  end

  def index_params
    params.permit(:page, :per_page, selected_ids: [])
  end

  def create_params
    params.permit(:product_id, :quantity)
  end

  def update_params
    params.permit(:quantity)
  end
end
