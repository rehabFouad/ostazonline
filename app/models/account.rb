class Account < ActiveRecord::Base
  attr_accessible :name, :type
  
  def self.types
    [:Asset,:Expense,:Equity,:Liability]
  end
end
