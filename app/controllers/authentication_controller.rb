class AuthenticationController < ApplicationController
  def register
    Authentications::RegisterService.call(register_params)

    render_message 'Register successful', meta: { http_status: :created }
  end

  def sign_in
    authentication = Authentications::SignInService.call(sign_in_params)

    render_serializer authentication, Authentications::AuthenticationSerializer
  rescue Authentications::Errors::Unauthorized
    render_error 'Unauthorized', meta: { http_status: :unauthorized }
  end

  def guest_in
    cookie_id = request.headers['Cookie']
    authentication = Authentications::GuestInService.call(cookie_id)

    render_serializer authentication, Authentications::TokenSerializer
  end

  private

  def register_params
    params.permit(:email, :name, :password, :password_confirmation, :phone_number, :address)
  end

  def sign_in_params
    params.permit(:email, :password)
  end
end
