class ApplicationController < ActionController::API
  include Serializable

  rescue_from Errors::ServiceError do |e|
    render_error e.message, meta: { http_status: :unprocessable_entity }
  end

  def authorize_request(*roles)
    AuthorizationService.call(request.headers['Authorization'], roles)
  rescue Errors::AuthorizationError => e
    render_error e.message, status: :unauthorized
  rescue Errors::ForbiddenError => e
    render_error 'Forbidden access', status: :forbidden
  end
end
