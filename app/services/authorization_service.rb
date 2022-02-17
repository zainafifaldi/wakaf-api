class AuthorizationService < AppService
  attr_reader :authorization_header, :roles

  def initialize(authorization_header, roles)
    @authorization_header = authorization_header
    @roles = roles
  end

  def call
    method, token = authorization_header.present? ? authorization_header.split(' ') : [nil, nil]

    raise Errors::AuthorizationError.new('Wrong authorization method') unless method == 'Token'

    authorize_token! token
    @current_user
  end

  private

  def authorize_token!(token)
    begin
      decoded_jwt = JsonWebToken.decode(token)
      @current_user = User.find(decoded_jwt[:user_id])

      raise Errors::ForbiddenError unless @current_user.valid_roles?(roles)
    rescue ActiveRecord::RecordNotFound => e
      raise Errors::AuthorizationError.new('Authorization failed')
    rescue JWT::DecodeError => e
      raise Errors::AuthorizationError.new(e.message)
    end
  end
end
