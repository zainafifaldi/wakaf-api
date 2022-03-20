module Transactions
  class IndexService < AppService
    MAX_PER_PAGE = 20

    include PaginatableResources

    attr_reader :current_user, :params

    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end

    def call
      transactions = Transaction.where(user_id: current_user.id)

      total = transactions.count

      transactions = transactions.order(id: :desc)
      transactions = set_pagination(transactions, params)
      transactions = transactions.includes(products: [:images])
      transactions = transactions.includes(:invoices) if params[:with_invoice].to_s == 'true'

      {
        transactions: transactions.all,
        page:         @page,
        per_page:     @per_page,
        total:        total
      }
    end
  end
end
