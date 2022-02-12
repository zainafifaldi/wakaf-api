class UsersController < ApplicationController
  before_action -> { authorize_request }

  def index
    render json: { ping: 'pong' }, status: :ok
  end
end
