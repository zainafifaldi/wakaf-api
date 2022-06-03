class AuthenticationsController < ApplicationController
  def register
    user = Authentications::RegisterService.call(register_params)

    Carts::GuestCartMigrationService.call(current_guest, user) if current_guest.present?

    authentication = Authentications::SignInService.call(register_params.permit(:email, :password))

    render_serializer authentication, Authentications::AuthenticationSerializer, meta: { http_status: :created }
  end

  def sign_in
    authentication = Authentications::SignInService.call(sign_in_params)

    Carts::GuestCartMigrationService.call(current_guest, authentication.user) if current_guest.present?

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
    params.permit(:email, :name, :password, :phone_number, :address)
  end

  def sign_in_params
    params.permit(:email, :password)
  end
end
