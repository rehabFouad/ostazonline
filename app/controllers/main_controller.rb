class MainController < ApplicationController
  def index
  end

  def balance_sheet
    @liability_accounts = Liability.all
    @asset_accounts = Asset.all
    @expense_accounts = Expense.all
    @equity_accounts = Equity.all
    
    
    
    
  end
end
