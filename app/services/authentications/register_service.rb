module Authentications
  class RegisterService < AppService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      validate_password!
      create_user
    end

    private

    def validate_password!
      raise Authentications::Errors::Register.new('Invalid password confirmation') if params[:password] != params[:password_confirmation]
    end

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
