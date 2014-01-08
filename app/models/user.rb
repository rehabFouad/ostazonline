class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable
  has_many :permissions, :dependent => :destroy
  accepts_nested_attributes_for :permissions, :allow_destroy => true
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :role, :permissions ,:permissions_attributes
  before_create :setup_username_from_email
  before_create :setup_default_role_for_new_users
  def self.rols
    [:Observer,:Accountant,:Entry]
  end

  def self.actions
    [:manage, :create, :read, :update, :destroy]
  end

  def self.subjects
    ["Account","Transaction","User","all"]
  end

  private

  def setup_username_from_email
    self.username = self.email.split('@')[0]
  end

  def setup_default_role_for_new_users
    if self.role.blank?
      self.role = :Default
    end
  end
end
