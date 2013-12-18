class Liability < Account
  def self.balance
      accounts_balance = BigDecimal.new('0')
      accounts = self.find(:all)
      accounts.each do |liability|
         accounts_balance += liability.balance
        
      end
      accounts_balance
    end
end