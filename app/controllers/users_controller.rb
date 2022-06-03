class UsersController < ApplicationController
  before_action -> { authorize_request }

  def index
    render json: { ping: 'pong' }, status: :ok
  end

  def show_me
    render_serializer current_user, Users::UserDetailSerializer
  end

  def update_me
    user = Users::UpdateService.call(current_user, user_params)

    render_serializer user, Users::UserDetailSerializer
  end

  private

  def user_params
    params.permit(:name, :email, :phone_number, :address, :old_password, :new_password)
  end
end
