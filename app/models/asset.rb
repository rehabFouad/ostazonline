class Asset < Account
  def self.balance
      accounts_balance = BigDecimal.new('0')
      accounts = self.find(:all)
      accounts.each do |asset|
         accounts_balance += asset.balance
        
      end
      accounts_balance
    end
end