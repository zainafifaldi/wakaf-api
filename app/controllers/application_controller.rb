class ApplicationController < ActionController::API
  def authorize_request
    authorization_header = request.headers['Authorization']
    method, token = authorization_header.present? ? authorization_header.split(' ') : [nil, nil]

    if method == 'Token'
      begin
        @decoded = JsonWebToken.decode(token)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: 'Authorization failed' }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    else
      render json: { errors: 'Wrong authorization method' }, status: :unauthorized
    end
  end
end
