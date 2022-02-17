class ApplicationController < ActionController::API
  include Serializable

  attr_accessor :current_user

  rescue_from Errors::ServiceError, ActiveRecord::RecordInvalid do |e|
    render_error e.message, meta: { http_status: :unprocessable_entity }
  end

  def authorize_request(*roles)
    @current_user = AuthorizationService.call(request.headers['Authorization'], roles)
  rescue Errors::AuthorizationError => e
    render_error e.message, { meta: { http_status: :unauthorized } }
  rescue Errors::ForbiddenError => e
    render_error 'Forbidden access', { meta: { http_status: :forbidden } }
  end

  def current_guest
    @current_guest ||= begin
      authorization_header = request.headers['Authorization']
      method, token = authorization_header.present? ? authorization_header.split(' ') : [nil, nil]

      return nil unless method == 'Guest'

      begin
        decoded_jwt = JsonWebToken.decode(token)
        Guest.find(decoded_jwt[:guest_id])
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user_or_guest
    current_guest || current_user
  end

  def authorize_user_or_guest
    @current_user = AuthorizationService.call(request.headers['Authorization'], [])
  rescue Errors::ServiceError
    render_error 'User unauthorized', { meta: { http_status: :unauthorized } } unless current_guest.present?
  end
end
