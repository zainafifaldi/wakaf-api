module StarSender
  class Text < StarSender::Base
    attr_reader :phone_number, :text

    def initialize(phone_number, text)
      @phone_number = phone_number
      @text = text
    end

    def send
      post('/sendText', nil, params)
    end

    private

    def params
      {
        tujuan: clean_phone_number(phone_number),
        message: text
      }
    end
  end
end
