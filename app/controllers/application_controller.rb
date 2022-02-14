class ApplicationController < ActionController::API
  include Serializable

  attr_accessor :current_user

  rescue_from Errors::ServiceError do |e|
    render_error e.message, meta: { http_status: :unprocessable_entity }
  end

  def authorize_request(*roles)
    @current_user = AuthorizationService.call(request.headers['Authorization'], roles)
  rescue Errors::AuthorizationError => e
    render_error e.message, status: :unauthorized
  rescue Errors::ForbiddenError => e
    render_error 'Forbidden access', status: :forbidden
  end

  def current_guest
    @current_guest ||= begin
      authorization_header = request.headers['Authorization']
      method, token = authorization_header.present? ? authorization_header.split(' ') : [nil, nil]

      return nil unless method == 'Guest'

      decoded_jwt = JsonWebToken.decode(token)
      Guest.find(decoded_jwt[:guest_id])
    end
  end
end
