class Ability
  include CanCan::Ability
  # Remember that CanCan is for a resource, meaning it must have a class(model).
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    user.permissions.each do |permission|
      if permission.subject_id.nil?
        can permission.action.to_sym, permission.subject_class == "all" ? permission.subject_class.to_sym : permission.subject_class.constantize
      else
        can permission.action.to_sym, permission.subject_class.constantize, :id => permission.subject_id
      end
    end
    #Appending Special cases
    case user.role
      when "Entry"
        can :manage, Transaction do |transaction|
          transaction.credit_account.try(:type) == "Expense" or transaction.debit_account.try(:type) == "Expense"
        end
        can :read, Account do |account|
          account.try(:type) == "Expense"
        end
      when nil
        raise CanCan::AccessDenied.new("Access denied, Please sign in first!")
      end
  end
end
