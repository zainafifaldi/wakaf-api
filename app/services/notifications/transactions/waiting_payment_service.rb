module Notifications
  module Transactions
    class WaitingPaymentService < AppService
      attr_reader :current_user, :transaction

      def initialize(current_user, transaction)
        @current_user = current_user
        @transaction = transaction
      end

      def call
        StarSender::Text.new(current_user.phone_number, build_message).send
      end

      private

      def build_message
        message = "[#{ENV['APP_NAME']}]\n"
        message += "Assalamu\'alaikum, Kak *#{current_user.name}*\n"
        message += "Terima kasih sudah menyalurkan wakaf untuk Pondok Saif Al-Ulum.\n\n"
        message += "Silakan lakukan pembayaran dengan nominal Rp *#{currency(total_amount)}* 😊\n"
        message += "\n"
        message += "Jazaakallaah khairan katsiiran."
        message
      end

      def total_amount
        transaction.invoices.first.amount + transaction.invoices.first.unique_code
      end

      def currency(amount)
        ActionController::Base.helpers.number_to_currency(amount, precision: 0, unit: "", delimiter: ".")
      end
    end
  end
end
