Feature: Authorize with various rols

As a System Admin
I want to be able to authorize my looged in users
So that
	My accountant should be able to see everything
	I should be able to see everything but not edit anything
	My data entry guy should be able to see only the expenses and nothing else


Background: There are Accounts and Transactions in the DB
  And the following accounts exist:
  | name            | type	  |
  | Bank            | Asset	  | 
  | Cash            | Asset	  | 
  | Office Expenses | Expense |
  
  And the following transactions exist (Has to have the same accounts as above):
  | description  	| debit_account  |credit_account  | amount |
  | Bank_to_Cash	| Bank		     |Cash			  | 1000.0 | 
  | Cash_to_Expense | Cash		     |Office Expenses | 1000.0 |
 
Scenario: Successfully authorize Accountant
    Given I am a new, authenticated "Accountant"
    When I am on the accounts page
		    Then I should see "Bank"
		    And I should see "Cash"
		    And I should see "Office Expenses"
		    And I should see the action "Account:Destroy"
		    And I should see the action "Account:Show"
    When I am on the transactions page
	    	Then I should see "Bank_to_Cash"
	    	And I should see "Cash_to_Expense"
	    	And I should see "1000"
	    	And I should see the action "Transaction:Destroy"
	When I am on the balance_sheet page
			Then I should see "1000"
			
Scenario: Successfully authorize Observer
    Given I am a new, authenticated "Observer"
    When I am on the accounts page
		    Then I should see "Bank"
		    And I should see "Cash"
		    And I should see "Office Expenses"
		    And I should not see the action "Account:Destroy"
		    And I should see the action "Account:Show"
    When I am on the transactions page
	    	Then I should see "Bank_to_Cash"
	    	And I should see "Cash_to_Expense"
	    	And I should see "1000"
	    	And I should not see the action "Transaction:Destroy"
	When I am on the balance_sheet page
			Then I should see "1000"

Scenario: Successfully authorize Entry
    Given I am a new, authenticated "Entry"
    When I am on the accounts page
		    Then I should not see "Bank"
		    And I should not see "Cash"
		    And I should see "Office Expenses"
		    And I should not see the action "Account:Destroy"
		    And I should see the action "Account:Show"
    When I am on the transactions page
	    	Then I should not see "Bank_to_Cash"
	    	And I should see "Cash_to_Expense"
	    	And I should see "1000"
	    	And I should see the action "Transaction:Destroy"
	When I am on the balance_sheet page
			Then I should see "You are not authorized to access this page."
			
Scenario: Successfully authorize Entry
    When I am on the accounts page
    		Then I should see "Access denied, Please sign in first!"