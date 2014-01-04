class TransactionsController < ApplicationController
  #load_and_authorize_resource
  def index
    @transactions = Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end

  def new
    authorize! :create, Transaction
    @accounts = Account.all
    @transaction = Transaction.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end

  end

  def create
    @transaction = Transaction.build({
    :attachment => params[:transaction][:attachment],
    :description => params[:transaction][:description],
    :attachment => params[:transaction][:attachment],
    :credit => {:account=>params[:transaction][:credit_account],:amount => params[:transaction][:amount]},
    :debit => {:account=>params[:transaction][:debit_account],:amount => params[:transaction][:amount]}
    })

    @transaction.save
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transactions_path, notice: 'Transaction was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if(@transaction.destroy)
        flash[:notice] = 'Transaction was successfully destroyed.'

        format.html { redirect_to transactions_path  }
        format.json { head :no_content }
      end
    end
  end
end