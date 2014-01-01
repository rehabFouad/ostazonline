class Transaction < ActiveRecord::Base
  attr_accessible :description, :credit_amount, :debit_amount, :credit_account, :debit_account, :attachment
  has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/:style/missing.png"

  has_one :credit_amount, :extend => AmountsExtension
  has_one :debit_amount, :extend => AmountsExtension
  has_one :credit_account, :through => :credit_amount, :source => :account
  has_one :debit_account, :through => :debit_amount, :source => :account
  def self.build(hash)
    transaction = Transaction.new(:description => hash[:description])
    transaction.attachment = hash[:attachment]

    debit_account = Account.find_by_name(hash[:debit][:account])
    transaction.debit_amount = DebitAmount.new(:account => debit_account, :amount => hash[:debit][:amount], :transaction => transaction)

    credit_account= Account.find_by_name(hash[:credit][:account])
    transaction.credit_amount = CreditAmount.new(:account => credit_account, :amount => hash[:credit][:amount], :transaction => transaction)

    transaction
  end

end
