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
      cannot :manage, User
    when "Entry"
      can :manage, Transaction do |transaction|
        transaction.credit_account.try(:type) == "Expense" or transaction.debit_account.try(:type) == "Expense"
      end
      can :read, Account do |account|
        account.try(:type) == "Expense" 
      end
      cannot :read, :balance
    when "Observer"
      can :read, :all
      cannot :edit, :all
      cannot :delete, :all
      cannot :create, :all
    when nil
      raise CanCan::AccessDenied.new("Access denied, Please sign in first!")
    end
  end
end