class Equity < Account
  def self.balance
      accounts_balance = BigDecimal.new('0')
      accounts = self.find(:all)
      accounts.each do |equity|
         accounts_balance += equity.balance
        
      end
      accounts_balance
    end
end