class TransactionsController < ApplicationController
  
  
  def index
    @transactions = Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end
  
 def new
   @accounts = Account.all
   @transaction = Transaction.new

   
   respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
   
 end
 
 def create
   
   @transaction_params = params[:transaction]
   @transaction_desc = @transaction_params["description"]
   @transaction_credit_account =  @transaction_params["credit_accounts"]
   @transaction_credit_amount =  @transaction_params["credit_amounts"]
   @transaction_debit_account =  @transaction_params["debit_accounts"]
   @transaction_debit_amount =  @transaction_params["debit_amounts"]
      
   @transaction = Transaction.build(
                  :description => @transaction_desc,
                  :debits => [
                    {:account => @transaction_debit_account, :amount => @transaction_debit_amount}], 
                  :credits => [
                    {:account => @transaction_credit_account, :amount => @transaction_credit_amount}])
  @transaction.save
  
  respond_to do |format|
      if @transaction.save
        format.html { redirect_to transactions_path, notice: 'Transaction was successfully created.' }
        
      else
        format.html { render action: "new" }
       
      end
    end
  
 end 
 
end