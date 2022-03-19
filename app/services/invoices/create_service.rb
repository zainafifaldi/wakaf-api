module Invoices
  class CreateService < AppService
    attr_reader :current_user, :transaction, :params

    def initialize(current_user, transaction, params)
      @current_user = current_user
      @transaction = transaction
      @params = params
    end

    def call
      Invoice.create!(
        transaction_id: transaction.id,
        user_id: current_user.id,
        amount: transaction_amount,
        payment_method: params[:payment_method],
        payment_detail: payment_detail
      )
    end

    private

    def transaction_amount
      amount = 0
      transaction.products.each do |product|
        amount += (product.price.to_i * product.quantity)
      end
      amount
    end

    def payment_detail
      Bank.banks[params[:bank_name]]&.to_json if params[:payment_method] == 'bank_transfer'
    end
  end
end
