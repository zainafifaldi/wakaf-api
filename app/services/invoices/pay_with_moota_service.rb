module Invoices
  class PayWithMootaService < AppService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      invoice = Invoice.find_by(state: :pending, total_transfer: params[:amount].to_i)

      raise Invoices::Errors::Payment, 'Invoice Not Found' unless invoice.present?

      payment_detail = generate_payment_detail(invoice)

      invoice.update_attributes(
        state: :paid,
        paid_at: DateTime.now,
        payment_detail: payment_detail.to_json
      )
      invoice.reload
    end

    private

    def generate_payment_detail(invoice)
      payment_detail = JSON.parse(invoice.payment_detail, symbolize_names: true)
      payment_detail.merge(payment: {
        provider:       'Moota',
        id:             params[:id],
        bank_id:        params[:bank_id],
        bank_type:      params[:bank_type],
        account_number: params[:account_number],
        mutation_id:    params[:mutation_id],
        date:           params[:date],
        amount:         params[:amount],
        description:    params[:description]
      })
    end
  end
end
