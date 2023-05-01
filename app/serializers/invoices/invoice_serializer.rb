module Invoices
  class InvoiceSerializer < ActiveModel::Serializer
    attributes :id,
               :transaction_id,
               :invoice_number,
               :amount,
               :unique_code,
               :total_amount,
               :payment_method,
               :payment_detail,
               :state,
               :expire_time,
               :payment_evidence_url,
               :created_at,
               :updated_at

    def total_amount
      object.amount + object.unique_code
    end

    def payment_detail
      JSON.parse(object.payment_detail)
    rescue JSON::ParserError
      object.payment_detail
    end
  end
end
