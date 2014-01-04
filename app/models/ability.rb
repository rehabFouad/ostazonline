class Ability
  include CanCan::Ability
  # Remember that CanCan is for a resource, meaning it must have a class(model).
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    case user.role
    when "Admin"
      can :manage, :all
    when "Accountant"
      can :manage, :all
    when "Entry"
      can :manage, Transaction do |transaction|
        transaction.credit_account.try(:name) == "Expenses" or transaction.debit_account.try(:name) == "Expenses"
      end
    when "Observer"
      can :read, :all
      cannot :edit, :all
      cannot :delete, :all
    when nil
      raise CanCan::AccessDenied.new("Access denied, Please sign in first!")
    end
  end
end