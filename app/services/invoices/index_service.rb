module Invoices
  class IndexService < AppService
    MAX_PER_PAGE = 20

    include PaginatableResources

    attr_reader :current_user, :params

    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end

    def call
      invoices = Invoice.where(user_id: current_user.id)
      invoices = invoices.where(state: params[:states]) if params[:states].present?

      total = invoices.count

      invoices = invoices.order(id: :desc)
      invoices = set_pagination(invoices, params)
      invoices = invoices.includes(trx: [products: [:images]]) if params[:with_detail].to_s == 'true'

      {
        invoices: invoices.all,
        page:     @page,
        per_page: @per_page,
        total:    total
      }
    end
  end
end
