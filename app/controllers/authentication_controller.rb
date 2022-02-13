class AuthenticationController < ApplicationController
  def sign_in
    @user = User.find_by_email(sign_in_params[:email])
    if @user&.authenticate(sign_in_params[:password])
      time = Time.now.utc + 24.hours.to_i
      token = JsonWebToken.encode({ user_id: @user.id }, time)
      render json: {
        token: token,
        expire_time: time,
        name: @user.name,
        email: @user.email,
        phone_number: @user.phone_number,
        address: @user.address
      }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def sign_in_params
    params.permit(:email, :password)
  end
end
