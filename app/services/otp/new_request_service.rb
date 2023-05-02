module Otp
  class NewRequestService < AppService
    OTP_LENGTH = 4

    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call
      otp = build_new_otp

      StarSender::Text.new(user.phone_number, build_message(otp)).send

      user.otp = otp
      user.save!
      user
    end

    private

    def build_new_otp
      otp = ''
      (1..OTP_LENGTH).each do |i|
        number = rand(1..9)
        otp = "#{otp}#{number}"
      end

      otp
    end

    def build_message(otp)
      message = "[Wakaf Pondok Saif Al-Ulum]\n"
      message += "Assalamu\'alaikum, Kak *#{user.name}*\n"
      message += "Berikut kode OTP dari aplikasi Wakaf untuk keperluan registrasi / login Kakak:\n\n"
      message += "*#{otp}*\n\n"
      message += "Mohon jangan dibagikan ke siapapun ya 😊\n"
      message += "Jazaakallaah khairan katsiiran"
      message
    end
  end
end
