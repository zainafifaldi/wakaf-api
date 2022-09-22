module External
  module Moota
    class ProcessorService < AppService
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def call
        raise External::Moota::Errors::InvalidParams, 'Invalid parameters' unless params.is_a?(Array)

        Rails.logger.info '>> Processing transactions from Moota...'
        params.each do |trx_param|
          begin
            Invoices::PayWithMootaService.call(trx_param)
            Rails.logger.info ">>> ID #{trx_param[:id]} Success"
          rescue ::Errors::ServiceError => e
            Rails.logger.info ">>> ID #{trx_param[:id]} Error: #{e.message}, Payload: #{trx_param.to_json}"
          end
        end
      end
    end
  end
end
