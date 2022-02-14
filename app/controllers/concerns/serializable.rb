module Serializable
  extend ActiveSupport::Concern

  ROOT_DEFAULT = 'data'.freeze
  ROOT_NOTICE = 'notice'.freeze
  ROOT_ERROR = 'error'.freeze

  def render_serializer(resource_or_resources, class_name, options = {})
    set_headers!

    render_params = default_options(resource_or_resources).merge(options)
    render_params[:meta] ||= {}
    render_params[:meta].reverse_merge!(http_status: :ok)
    render_params[:status] = render_params[:meta][:http_status]
    render_params[:meta][:http_status] = get_http_status(render_params[:meta][:http_status])

    if resource_or_resources.is_a?(Array)
      render_params[:each_serializer] = class_name
    else
      render_params[:serializer] = class_name
    end

    render render_params
  end

  def render_message(message, options)
    render_serializer Serializers::Message.new(message), MessageSerializer, options.merge(root: ROOT_NOTICE)
  end
  
  def render_error(error, options)
    options[:meta][:http_status] = :unprocessable_entity unless options[:meta].present? && options[:meta][:http_status].present?

    render_serializer Serializers::Message.new(error), MessageSerializer, options.merge(root: ROOT_ERROR)
  end

  def get_http_status(http_status)
    http_status.is_a?(Symbol) ? Rack::Utils::SYMBOL_TO_STATUS_CODE[http_status] : http_status
  end

  private

  def set_headers!
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  def default_options(resource_or_resources)
    {
      json: resource_or_resources,
      adapter: :json,
      root: ROOT_DEFAULT
    }
  end
end
