module Errors
  class ServiceError < StandardError; end

  class AuthorizationError < Errors::ServiceError; end
  class ForbiddenError < Errors::ServiceError; end
end
