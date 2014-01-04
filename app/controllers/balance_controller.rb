class BalanceController < ApplicationController
  def index
    authorize! :read, @account
    @liability_accounts = Liability.all
    @asset_accounts = Asset.all
    @expense_accounts = Expense.all
    @equity_accounts = Equity.all
  end
end
