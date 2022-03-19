module Invoices
  class InvoiceSerializer < ActiveModel::Serializer
    attributes :id,
               :transaction_id,
               :invoice_number,
               :amount,
               :payment_method,
               :payment_detail,
               :state,
               :expire_time,
               :payment_evidence_url,
               :created_at,
               :updated_at
  end
end
