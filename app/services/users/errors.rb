module Users
  module Errors
    class InvalidOldPassword < ::Errors::ServiceError
      def initialize; super('Old password is invalid'); end
    end

    class NotFound < ::Errors::ServiceError
      def initialize; super('User not found'); end
    end
  end
end
