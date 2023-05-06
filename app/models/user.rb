class User < ApplicationRecord
  has_secure_password

  before_validation do
    self.password = '123456' if password.blank?
  end

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

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
