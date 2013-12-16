class Amount < ActiveRecord::Base
  
  attr_accessible :amount, :account, :transaction
  
  belongs_to :transaction
  belongs_to :account

end
