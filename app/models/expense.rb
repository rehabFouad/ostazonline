class Expense < Account
  def self.balance
      accounts_balance = BigDecimal.new('0')
      accounts = self.find(:all)
      accounts.each do |expense|
         accounts_balance += expense.balance
        
      end
      accounts_balance
    end
end