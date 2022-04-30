module Users
  class UserDetailSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :email,
               :phone_number,
               :address,
               :email_verified,
               :roles,
               :created_at,
               :updated_at

    def roles
      object.roles_adjustment.to_s.split(',')
    end
  end
end
