module Notifications
  module Transactions
    class CompleteService < AppService
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
        message += "Terima kasih sudah menyalurkan wakaf untuk Pondok Saif Al-Ulum.\n"
        message += "\n"
        message += "Alhamdulillaah Pembayaran Kakak sudah kami terima dengan detail sebagai berikut:\n"
        message += "\n"
        message += "*Nomor Transaksi*: #{transaction.transaction_number}\n"
        message += "*Nama Pewakaf*: #{transaction.donor_name}\n"
        message += "*Nomor HP Pewakaf*: #{transaction.donor_phone_number}\n"
        message += "*Email Pewakaf*: #{transaction.donor_email}\n"
        message += "*Produk Wakaf*:\n"
        message += build_products
        message += "\n"
        message += "Dengan Total Pembayaran: *Rp #{currency(transaction.invoices.first.amount)}*"
        message += " (*+#{currency(transaction.invoices.first.unique_code)}* kode unik)\n"
        message += "\n"
        message += "Klik link ini untuk melihat transaksi Kakak:\n"
        message += "#{ENV['TRANSACTIONS_LINK']}\n"
        message += "\n"
        message += "Jazaakallaah khairan katsiiran.\n"
        message += "Semoga Allaah membalas kebaikan Kakak."
        message
      end

      def build_products
        message = ""
        transaction.products.each do |product|
          message += "\t- #{product.name} -"
          message += " Rp #{currency(product.price)}"
          message += " sebanyak #{product.quantity} produk\n"
        end

        message
      end

      def currency(amount)
        ActionController::Base.helpers.number_to_currency(amount, precision: 0, unit: "", delimiter: ".")
      end
    end
  end
end
