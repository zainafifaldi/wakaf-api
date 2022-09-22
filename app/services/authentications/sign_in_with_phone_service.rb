module Authentications
  class SignInWithPhoneService < AppService
    attr_reader :params, :time_to_live

    def initialize(params)
      @params = params
      @time_to_live = Time.now.utc + 24.hours.to_i
    end

    def call
      user = Otp::ValidationService.call(params[:phone_number], params[:otp])
      token = set_token(user)

      Serializers::Authentication.new(
        user: user,
        token: token,
        expire_time: time_to_live
      )
    end

    private

    def set_token(user)
      JsonWebToken.encode({ user_id: user.id }, time_to_live)
    end
  end
end
