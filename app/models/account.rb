class Account < ActiveRecord::Base
  attr_accessible :name, :type
  
  has_many :credit_amounts, :extend => AmountsExtension
  has_many :debit_amounts, :extend => AmountsExtension
  has_many :credit_transactions, :through => :credit_amounts, :source => :transaction
  has_many :debit_transactions, :through => :debit_amounts, :source => :transaction
  
  validates_presence_of :type, :name
  validates_uniqueness_of :name
  
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
      case type
      when "Asset"
        debits_balance - credits_balance
      when "Expense"
        debits_balance - credits_balance
      when "Equity"
        credits_balance - debits_balance
      when "Liability"
        credits_balance - debits_balance
      end
    end

    
    def self.all_balance
         (Asset.balance + Revenue.balance) - (Liability.balance + Equity.balance + Expense.balance)
    end

  end

