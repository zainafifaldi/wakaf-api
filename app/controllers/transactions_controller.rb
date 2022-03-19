class TransactionsController < ApplicationController
  before_action -> { authorize_request }
  before_action :validate_resource!, only: [:show]

  def create
    validate_create_params!

    ActiveRecord::Base.transaction do
      @transaction = Transactions::CreateService.call(current_user, create_params)
      Carts::BatchRemoveService.call(current_user, create_params[:cart_ids])
    end

    render_serializer @transaction, Transactions::TransactionDetailSerializer, { meta: { http_status: :created } }
  end

  def show
    render_serializer current_resource, Transactions::TransactionDetailSerializer
  end

  private

  def create_params
    params.permit(:donor_name, :donor_phone_number, :donor_email, :payment_method, :bank_name, cart_ids: [])
  end

  def validate_resource!
    if current_resource.present?
      render_error('Forbidden access to resource', { meta: { http_status: :forbidden } }) unless resource_owner?
    else
      render_error('Transaction not found', { meta: { http_status: :not_found } })
    end
  end

  def resource_owner?
    current_resource.user_id == current_user.id
  end

  def current_resource
    @current_resource ||= begin
      transaction = Transaction.find_by(id: params[:id])
      transaction = Transaction.find_by(transaction_number: params[:id]) unless transaction.present?
      transaction
    end
  end
end
