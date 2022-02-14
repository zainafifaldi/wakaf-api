class ApplicationController < ActionController::API
  rescue_from Errors::ServiceError do |e|
    render_error e.message, status: :unprocessable_entity
  end

  def render_serializer(resource_or_resources, class_name, options = {})
    render_params = { json: resource_or_resources }.merge(options)

    if resource_or_resources.is_a?(Array)
      render_params[:each_serializer] = class_name
    else
      render_params[:serializer] = class_name
    end

    render render_params
  end

  def render_message(message, options)
    render_params = { json: { message: message } }.merge(options)
    render_params[:status] = :ok unless render_params[:status].present?
    render render_params
  end
  
  def render_error(error, options)
    render_params = { json: { error: error } }.merge(options)
    render_params[:status] = :unprocessable_entity unless render_params[:status].present?
    render render_params
  end

  def authorize_request(*roles)
    AuthorizationService.call(request.headers['Authorization'], roles)
  rescue Errors::AuthorizationError => e
    render_error e.message, status: :unauthorized
  rescue Errors::ForbiddenError => e
    render_error 'Forbidden access', status: :forbidden
  end
end
