module Invoices
  class InvoiceDetailSerializer < InvoiceSerializer
    belongs_to :transaction, serializer: Transactions::TransactionSerializer

    def transaction
      object.trx
    end
  end
end
