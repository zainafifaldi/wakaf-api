module Serializers
  class Message < ActiveModelSerializers::Model
    attr_reader :message

    def initialize(message)
      @message = message
    end
  end
end
