module Authentications
  class RegisterService < AppService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      create_user
    end

    private

    def create_user
      User.create!(
        name: params[:name],
        email: params[:email],
        phone_number: params[:phone_number],
        address: params[:address],
        password: params[:password]
      )
    rescue ActiveRecord::RecordInvalid => e
      raise Authentications::Errors::Register.new(e.message)
    end
  end
end
