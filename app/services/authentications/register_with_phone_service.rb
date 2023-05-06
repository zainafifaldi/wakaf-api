module Authentications
  class RegisterWithPhoneService < AppService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      user = User.find_by_phone_number(params[:phone_number])
      if user.present? && !user.phone_number_verified
        update_user(user)
      else
        user = RegisterService.call(params)
      end

      user
    end

    private

    def update_user(user)
      user.update!(
        name: params[:name],
        email: params[:email],
        address: params[:address],
        password: params[:password]
      )
    end
  end
end
