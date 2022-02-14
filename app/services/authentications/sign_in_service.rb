module Authentications
  class SignInService < ApplicationService
    attr_reader :params, :time_to_live

    def initialize(params)
      @params = params
      @time_to_live = Time.now.utc + 24.hours.to_i
    end

    def call
      authenticate_user
      token = set_token

      Serializers::Authentication.new(
        user: user,
        token: token,
        expire_time: time_to_live
      )
    end

    private

    def authenticate_user
      authenticated = user&.authenticate(params[:password])

      raise Authentications::Errors::Unauthorized unless authenticated
    end

    def user
      @user ||= User.find_by_email(params[:email])
    end
    
    def set_token
      JsonWebToken.encode({ user_id: user.id }, time_to_live)
    end
  end
end
