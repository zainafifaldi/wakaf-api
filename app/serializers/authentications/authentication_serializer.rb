module Authentications
  class AuthenticationSerializer < ActiveModel::Serializer
    attributes :token,
               :expire_time,
               :name,
               :email,
               :phone_number,
               :address

    delegate :name, :email, :phone_number, :address, to: :'object.user'
  end
end
