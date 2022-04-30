module Users
  module Errors
    class InvalidOldPassword < ::Errors::ServiceError
      def initialize; super('Old password is invalid'); end
    end
  end
end
