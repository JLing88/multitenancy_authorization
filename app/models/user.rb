class User < ActiveRecord::Base
  has_secure_password

  belongs_to :store
  has_many :orders

  has_many :user_roles
  has_many :roles, through: :user_roles

  def registered_user?
    roles.exists?(name: "registered_user")
  end

  def admin?
    roles.exists?(name: "admin")
  end

  def store_admin?
    roles.exists?(name: "store_admin")
  end
end
