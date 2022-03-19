class InvoicesController < ApplicationController
  before_action -> { authorize_request }
  before_action -> { validate_resource!(current_resource_by_trx) }, only: [:show_by_trx]

  def show_by_trx
    validate_resource!(current_resource_by_trx)

    render_serializer current_resource_by_trx, Invoices::InvoiceSerializer
  end

  private

  def validate_resource!(resource)
    if resource.present?
      render_error('Forbidden access to resource', { meta: { http_status: :forbidden } }) unless resource_owner?(resource)
    else
      render_error('Invoice not found', { meta: { http_status: :not_found } })
    end
  end

  def resource_owner?(resource)
    resource.user_id == current_user.id
  end

  def current_resource_by_trx
    @current_resource ||= begin
      invoice = Invoice.find_by(transaction_id: params[:transaction_id])
      unless invoice.present?
        transaction = Transaction.find_by(transaction_number: params[:transaction_id])
        invoice = transaction.invoices.first if transaction.present?
      end

      invoice
    end
  end
end
