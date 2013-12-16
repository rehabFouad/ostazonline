class Account < ActiveRecord::Base
  attr_accessible :name, :type
  
  has_many :credit_amounts, :extend => AmountsExtension
  has_many :debit_amounts, :extend => AmountsExtension
  has_many :credit_transactions, :through => :credit_amounts, :source => :transaction
  has_many :debit_transactions, :through => :debit_amounts, :source => :transaction

  
  def self.types
    [:Asset,:Expense,:Equity,:Liability]
  end
end
