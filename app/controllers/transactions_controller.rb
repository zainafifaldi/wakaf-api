class TransactionsController < ApplicationController
  before_action -> { authorize_request }

  def create
    validate_create_params!

    ActiveRecord::Base.transaction do
      @transaction = Transactions::CreateService.call(current_user, create_params)
      Carts::BatchRemoveService.call(current_user, create_params[:cart_ids])
    end

    render_serializer @transaction, Transactions::TransactionDetailSerializer, { meta: { http_status: :created } }
  end

  private

  def create_params
    params.permit(:donor_name, :donor_phone_number, :donor_email, :payment_method, :bank_name, cart_ids: [])
  end
end
