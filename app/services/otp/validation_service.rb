module Otp
  class ValidationService < AppService
    attr_reader :phone_number, :otp

    def initialize(phone_number, otp)
      @phone_number = phone_number
      @otp = otp
    end

    def call
      validate_user!
      validate_otp!

      user.phone_number_verified = true
      user.otp = nil
      user.save!
      user
    end

    private

    def user
      @user ||= User.find_by_phone_number(phone_number)
    end

    def validate_user!
      raise Users::Errors::NotFound unless user.present?
    end

    def validate_otp!
      raise Otp::Errors::Validation if user.otp.blank? || user.otp != otp
    end
  end
end
