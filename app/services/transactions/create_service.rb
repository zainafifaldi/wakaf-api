module Transactions
  class CreateService < AppService
    attr_reader :current_user, :params, :transaction

    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end

    def call
      validate_carts!

      @transaction = create_transaction

      @transaction = TransactionProducts::CreateFromCartService.call(current_user, transaction, params[:cart_ids])
      @transaction.invoices << Invoices::CreateService.call(current_user, transaction, params)

      Notifications::Transactions::WaitingPaymentService.call(current_user, transaction)

      transaction
    end

    private

    def validate_carts!
      raise Carts::Errors::Empty.new('You have not selected any cart') if params[:cart_ids].count == 0

      unavailable_carts = Carts::CheckAvailabilityService.call(current_user, params[:cart_ids])
      raise Carts::Errors::QuantityUncovered if unavailable_carts.present?
    end

    def create_transaction
      Transaction.create!(
        user_id: current_user.id,
        donor_name: params[:donor_name],
        donor_phone_number: params[:donor_phone_number],
        donor_email: params[:donor_email]
      )
    end
  end
end
