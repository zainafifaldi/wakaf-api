module Products
  module Errors
    class NotFound < ::Errors::ServiceError
      def initialize; super('Product not found'); end
    end
  end
end
