module Transactions
  class TransactionWithInvoiceSerializer < TransactionSerializer
    has_one :invoice, serializer: Invoice::InvoiceSerializer

    def invoice
      object.invoices.first
    end
  end
end
