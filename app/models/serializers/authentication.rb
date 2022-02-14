module Serializers
  class Authentication < ActiveModelSerializers::Model
    attr_reader :user,
                :token,
                :expire_time

    def initialize(params)
      @user = params[:user]
      @token = params[:token]
      @expire_time = params[:expire_time]
    end
  end
end
