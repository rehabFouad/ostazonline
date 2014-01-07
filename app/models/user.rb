class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :permissions
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :role, :permissions
  validates_presence_of :role
  before_create :setup_username_from_email


  def self.rols
    [:Observer,:Accountant,:Entry]
  end
  
  private
  def setup_username_from_email
      self.username = self.email.split('@')[0]
  end
end
