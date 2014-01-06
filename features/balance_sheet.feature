Feature: View balance sheet

As a CFE
I want to be able to view the balance sheet
So that I can have a detailed view of all accounts and status

Background: User is logged in as Admin and there is Accounts and Transactions in the DB
  Given I am a new, authenticated "Admin"
  And the following accounts exist:
  | name                   | type  | 
  | Cash                   | Asset | 
  | Bank                   | Asset |
  And the following transactions exist (Has to have the same accounts as above):
  | description  | debit_account |credit_account | amount | 
  | Cash_to_Bank | Cash		     |Bank			 | 1000.0 |
 
Scenario: Successfully view balance sheet
    Given I am on the balance_sheet page
    Then I should see "1000"