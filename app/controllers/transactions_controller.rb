class TransactionsController < ApplicationController
  
 def new
   @accounts = Account.all
   @transaction = Transaction.new

   
   respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
   
 end
 
 def create
 # @transaction = Transaction.build(
  #              :description => params[:transaction["description"]],
   #             :debits => [
    #              {:account => params[:transaction["debit_accounts"]], :amount => params[:transaction["debit_amounts"]]}], 
     ##            {:account => params[:transaction["credit_accounts"]], :amount => params[:transaction["credit_amounts"]]}])
                  
      #@transaction.save 
      
                
   
 end 
 
end