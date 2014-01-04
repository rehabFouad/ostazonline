class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :role
  before_create :setup_default_role_for_new_users


  def self.rols
    [:Observer,:Accountant,:Entry]
  end
  
  private
  def setup_default_role_for_new_users
    if self.role.blank?
      self.role = :Default
    end
  end
end
