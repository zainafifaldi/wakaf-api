module StarSender
  class Base
    include HTTParty

    def post(endpoint, body = nil, params = nil)
      result = if body
                 ::HTTParty.post(ENV['STAR_SENDER_BASE_URL'] + endpoint,
                                 query:   params,
                                 body:    body.to_json,
                                 headers: headers)
               else
                 ::HTTParty.post(ENV['STAR_SENDER_BASE_URL'] + endpoint,
                                 query:   params,
                                 headers: headers)
               end
      ::JSON.parse(result.body, symbolize_names: true)
    end

    def headers
      {
        'apikey':        ENV['STAR_SENDER_API_KEY'],
        'Content-Type':  'application/json'
      }
    end

    def clean_phone_number(phone_number)
      phone_number = "62#{phone_number[1..-1]}" if phone_number[0] == '0'
      phone_number = "#{phone_number[1..-1]}" if phone_number[0] == '+'
      phone_number = "62#{phone_number[0..-1]}" if phone_number[0..1] != '62'
      phone_number
    end
  end
end
