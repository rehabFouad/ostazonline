class AccountsController < ApplicationController
  load_and_authorize_resource
  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = Account.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.json
  def new
    @account = Account.new
    @account_types = Account.types
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account }
    end
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(params[:account])

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render json: @account, status: :created, location: @account }
      else
        @account_types = Account.types
        flash[:error] = @account.errors.full_messages.join(",")

        format.html { render action: "new" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account = Account.find(params[:id])

    respond_to do |format|
      transaction = Amount.where(account_id: @account.id)[0].try(:transaction)
      if(transaction)
        Amount.where(transaction_id: transaction.id).destroy_all
        transaction.destroy
      end
      if(@account.destroy)
        flash[:notice] = 'Account was successfully destroyed.'
        
        format.html { redirect_to accounts_path  }
        format.json { head :no_content }
      end
    end
  end
end
