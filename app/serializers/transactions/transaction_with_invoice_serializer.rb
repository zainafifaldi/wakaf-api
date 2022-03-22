module Transactions
  class TransactionWithInvoiceSerializer < TransactionSerializer
    has_one :invoice, serializer: Invoices::InvoiceSerializer

    def invoice
      object.invoices.first
    end
  end
end
