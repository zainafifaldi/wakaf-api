module Authentications
  class GuestInService < ApplicationService
    attr_reader :cookie_id

    def initialize(cookie_id)
      @cookie_id = cookie_id.to_s
    end

    def call
      register_guest_if_first!
      token = set_token

      Serializers::Authentication.new(token: token)
    end

    private

    def register_guest_if_first!
      return if guest.present?

      Guest.create!(cookie_id: cookie_id)
    rescue => e
      raise Authentications::Errors::Register.new(e.message)
    end

    def guest
      @guest ||= Guest.find_by_cookie_id(cookie_id)
    end
    
    def set_token
      JsonWebToken.encode({ guest_id: guest.id })
    end
  end
end
