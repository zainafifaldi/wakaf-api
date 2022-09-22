module Invoices
  class CreateService < AppService
    attr_reader :current_user, :transaction, :params

    def initialize(current_user, transaction, params)
      @current_user = current_user
      @transaction = transaction
      @params = params
    end

    def call
      unique_code, total_transfer = Invoices::UniqueCodeGeneratorService.call(transaction_amount, params)

      Invoice.create!(
        transaction_id: transaction.id,
        user_id: current_user.id,
        amount: transaction_amount,
        unique_code: unique_code,
        total_transfer: total_transfer,
        payment_method: params[:payment_method],
        payment_detail: payment_detail
      )
    end

    private

    def transaction_amount
      @transaction_amount ||= begin
        amount = 0
        transaction.products.each do |product|
          amount += (product.price.to_i * product.quantity)
        end
        amount
      end
    end

    def payment_detail
      Bank.banks[params[:bank_name]]&.to_json if ['bank_transfer', 'bank_transfer_automatic'].include?(params[:payment_method])
    end
  end
end
