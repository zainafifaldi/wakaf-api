class TransactionsController < ApplicationController
  before_action -> { authorize_request }
  before_action :validate_resource!, only: [:show]

  def create
    validate_create_params!

    ActiveRecord::Base.transaction do
      @transaction = Transactions::CreateService.call(current_user, create_params)
      Carts::BatchRemoveService.call(current_user, create_params[:cart_ids])
    end

    render_serializer @transaction, Transactions::TransactionSerializer, { meta: { http_status: :created } }
  end

  def index
    result = Transactions::IndexService.call(current_user, index_params)

    meta_options = {
      page:     (result[:page] || 1),
      per_page: result[:per_page],
      total:    result[:total]
    }

    render_serializer result[:transactions].to_a, transactions_serializer, { meta: meta_options }
  end

  def show
    render_serializer current_resource, Transactions::TransactionSerializer
  end

  private

  def create_params
    params.permit(:donor_name, :donor_phone_number, :donor_email, :payment_method, :bank_name, cart_ids: [])
  end

  def index_params
    params.permit(:page, :per_page, :with_invoice)
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

  def transactions_serializer
    params[:with_invoice].to_s == 'true' ? Transactions::TransactionWithInvoiceSerializer : Transactions::TransactionSerializer
  end
end
