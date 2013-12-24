Feature: Create a new account

As an Accountant 
I want to be able to add new accounts 
so that I can maintain list of accounts for transactions
 
 
Scenario: Successfully create new account
    Given I am on the accounts page
    When I follow "New Account"
    Then I should be on the new account page
    When I fill in "account_name" with "Cash"
    And I select "Asset" from "account_type"
    And I press "Create Account"
    Then I should see "Account was successfully created."
    