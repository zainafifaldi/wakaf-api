module Invoices
  module Errors
    class UniqueCode < ::Errors::ServiceError; end
    class Payment < ::Errors::ServiceError; end
  end
end
