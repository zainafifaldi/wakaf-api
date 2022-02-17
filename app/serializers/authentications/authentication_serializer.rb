module Authentications
  class AuthenticationSerializer < ActiveModel::Serializer
    attributes :token,
               :expire_time,
               :user_id,
               :name,
               :email,
               :phone_number,
               :address

    delegate :name, :email, :phone_number, :address, to: :'object.user'

    def user_id
      object.user.id
    end
  end
end
