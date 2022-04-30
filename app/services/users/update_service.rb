module Users
  class UpdateService < AppService
    attr_reader :user, :params

    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      validate_password!

      @user.update_attributes!(update_params)

      @user.reload
    end

    private

    def validate_password!
      return unless params[:new_password].present?

      raise Users::Errors::InvalidOldPassword unless user&.authenticate(params[:old_password])
    end

    def update_params
      new_params = params.except(:old_password, :new_password)
      new_params = new_params.merge({ password: params[:new_password] }) if params[:new_password].present?
      new_params
    end
  end
end
