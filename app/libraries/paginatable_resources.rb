module PaginatableResources
  extend ActiveSupport::Concern

  included do |klass|
    MAX_PER_PAGE = klass::MAX_PER_PAGE
  end

  def set_pagination(resource, params)
    resource = resource.limit(per_page(params))
    resource = resource.offset([(page(params) - 1), 0].max * per_page(params).to_i) if params[:page].present?
    resource
  end

  def per_page(params)
    params[:per_page] = (params[:per_page] || MAX_PER_PAGE)
    @per_page = [params[:per_page].to_i.abs, MAX_PER_PAGE].min
  end

  def page(params)
    @page = params[:page].to_i.abs
  end
end
