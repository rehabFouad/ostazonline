class Account < ActiveRecord::Base
  attr_accessible :name, :type
  
  has_many :credit_amounts, :extend => AmountsExtension
  has_many :debit_amounts, :extend => AmountsExtension
  has_many :credit_transactions, :through => :credit_amounts, :source => :transaction
  has_many :debit_transactions, :through => :debit_amounts, :source => :transaction

  
  def self.types
    [:Asset,:Expense,:Equity,:Liability]
  end
  
  
    def credits_balance
      credit_amounts.balance
    end

   
    def debits_balance
      debit_amounts.balance
    end

    def balance
        credits_balance - debits_balance
    end

    
    def self.all_balance
         Asset.balance - (Liability.balance + Equity.balance + Revenue.balance - Expense.balance)
    end

  end

