class BalanceController < ApplicationController
  def index
    authorize! :read, :balance
    @liability_accounts = Liability.all
    @asset_accounts = Asset.all
    @expense_accounts = Expense.all
    @equity_accounts = Equity.all
  end
end
