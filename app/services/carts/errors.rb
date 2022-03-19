module Carts
  module Errors
    class CheckAvailabilityBlank < ::Errors::ServiceError; end
    class Empty < ::Errors::ServiceError; end
    class QuantityUncovered < ::Errors::ServiceError
      def initialize; super('There is uncovered quantity in cart'); end
    end
  end
end
