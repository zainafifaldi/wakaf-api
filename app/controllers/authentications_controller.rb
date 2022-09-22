class AuthenticationsController < ApplicationController
  ACTIONS = {
    '1': :register,
    '2': :sign_in
  }

  def register
    user = Authentications::RegisterService.call(register_params)

    Carts::GuestCartMigrationService.call(current_guest, user) if current_guest.present?

    authentication = Authentications::SignInService.call(register_params.permit(:email, :password))

    render_serializer authentication, Authentications::AuthenticationSerializer, meta: { http_status: :created }
  end

  def register_with_phone
    user = Authentications::RegisterService.call(register_params)

    user = Otp::NewRequestService.call(user)

    render_serializer user, Users::UserDetailSerializer, meta: { http_status: :created }
  end

  def sign_in_with_phone
    user = User.find_by_phone_number(params[:phone_number])

    raise Authentications::Errors::Unauthorized unless user.present?

    Otp::NewRequestService.call(user)

    render_message 'Phone number is accepted', meta: { http_status: :accepted }
  rescue Authentications::Errors::Unauthorized
    render_error 'Phone number is not registered', meta: { http_status: :unauthorized }
  end

  def validate_otp
    authentication = Authentications::SignInWithPhoneService.call(validate_otp_params)

    if ACTIONS[validate_otp_params[:action]] == :register && current_guest.present?
      Carts::GuestCartMigrationService.call(current_guest, user)
    end

    render_serializer authentication, Authentications::AuthenticationSerializer, meta: { http_status: :accepted }
  rescue Otp::Errors::Validation
    render_error 'Invalid OTP', meta: { http_status: :unauthorized }
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

  def validate_otp_params
    params.permit(:phone_number, :otp, :action)
  end
end
