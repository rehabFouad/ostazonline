class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  before_create :setup_default_role_for_new_users

  ROLES = %w[admin default banned]

  private
  def setup_default_role_for_new_users
    if self.role.blank?
      self.role = "default"
    end
  end
end
