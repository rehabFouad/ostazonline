Feature: Create a new Transaction

As an Accountant
I want to be able to record transactions
So that I can manipulate the accounts balance


Background: Accounts have been added to database
  
  Given the following accounts exist:
  | name                   | type  | 
  | Cash                   | Asset | 
  | Bank                   | Asset | 


Scenario: Successfully create new account
    Given I am on the transactions page
    When I follow "New Transaction"
    Then I should be on the new transaction page
    When I fill in "transaction_description" with "Description"
    And I select "Cash" from "transaction_credit_accounts"
    And I select "Bank" from "transaction_debit_accounts"
    And I fill in "transaction_credit_amounts" with "100"
    #And I fill in "transaction_debit_amounts" with "100"
    
    And I press "Create Transaction"
    Then I should see "Transaction was successfully created."
    