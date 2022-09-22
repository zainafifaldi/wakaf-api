module External
  class MootaController < ExternalAppController
    before_action :authorize_moota

    def pay_invoice
      External::Moota::ProcessorService.call(pay_invoice_params)

      render_message 'Payment has been accepted', { meta: { http_status: :accepted } }
    end

    private

    def authorize_moota
      header_signature = request.headers['Signature']
      signature = OpenSSL::HMAC.hexdigest('SHA256', ENV['MOOTA_SECRET_TOKEN'], params[:_json].to_json)

      return true if signature == header_signature

      render_error 'Moota authorization failed', { meta: { http_status: :unauthorized } }
    end

    def pay_invoice_params
      params.permit(_json: [
        :id, :bank_id, :bank_type, :account_number, :date, :description, :amount,
        :type, :balance, :created_at, :updated_at, :mutation_id, :token
      ])[:_json]
    end
  end
end
