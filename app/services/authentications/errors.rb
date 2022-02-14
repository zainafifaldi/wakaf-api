module Authentications
  module Errors
    class Unauthorized < ::Errors::ServiceError; end
    class Register < ::Errors::ServiceError; end
  end
end
