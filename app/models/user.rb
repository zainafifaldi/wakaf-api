class User < ApplicationRecord
  has_secure_password

  ROLE = {
    manager:  1,
    operator: 2
  }

  def roles
    self.roles_adjustment.split(',').map { |r| ROLE.key(r.to_i) }
  end

  def valid_roles?(roles_param=[])
    return true if roles_param.empty?

    roles_intersection = roles & roles_param
    roles_intersection.present? ? true : false
  end
end
