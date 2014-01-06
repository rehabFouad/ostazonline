Feature: Create a new Transaction

As an Accountant
I want to be able to record transactions
So that I can manipulate the accounts balance


Background: Accounts have been added to database
  Given I am a new, authenticated "Admin"
  And the following accounts exist:
  | name                   | type  | 
  | Cash                   | Asset | 
  | Bank                   | Asset |
  And the following transactions exist (Has to have the same accounts as above):
  | description  | debit_account |credit_account | amount | 
  | Cash_to_Bank | Cash		     |Bank			 | 1000.0 |

Scenario: Successfully create new transactions
    Given I am on the transactions page
    When I follow "New Transaction"
    Then I should be on the new transaction page
    When I fill in "transaction_description" with "Description"
    And I select "Cash" from "transaction_credit_account"
    And I select "Bank" from "transaction_debit_account"
    And I fill in "transaction_amount" with "100"
    And I press "Create Transaction"
    Then I should see "Transaction was successfully created."

Scenario: Successfully delete transactions
    Given I am on the transactions page
    And I delete the first record in transactions
    Then I should see "Transaction was successfully destroyed."