class Ability
  include CanCan::Ability
  # Remember that CanCan is for a resource, meaning it must have a class(model).

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role == "admin"
      can :manage, :all
    elsif user.role == "default"
      can :manage, Transaction
      cannot :destroy, Account
    elsif user.role == "banned"
      cannot :manage, :all
    else
      can :read, Transaction # guest user
    end
  end
end