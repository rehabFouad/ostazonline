class Transaction < ActiveRecord::Base
  attr_accessible :description
  
  has_many :credit_amounts, :extend => AmountsExtension
  has_many :debit_amounts, :extend => AmountsExtension
  has_many :credit_accounts, :through => :credit_amounts, :source => :account
  has_many :debit_accounts, :through => :debit_amounts, :source => :account
  
   def self.build(hash)
      transaction = Transaction.new(:description => hash[:description])
      hash[:debits].each do |debit|
        a = Account.find_by_name(debit[:account])
        transaction.debit_amounts << DebitAmount.new(:account => a, :amount => debit[:amount], :transaction => transaction)
      end
      hash[:credits].each do |credit|
        a = Account.find_by_name(credit[:account])
        transaction.credit_amounts << CreditAmount.new(:account => a, :amount => credit[:amount], :transaction => transaction)
      end
      transaction
    end


end
