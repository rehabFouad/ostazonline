Feature: Create a new account

As an Accountant 
I want to be able to add new accounts 
so that I can maintain list of accounts for transactions

Background: User is logged in as Admin
Given I am a new, authenticated "Admin"
And the following accounts exist:
  | name                   	   | type  | 
  | CashTest                   | Asset | 
 
Scenario: Successfully create new account
    And I am on the accounts page
    When I follow "New Account"
    Then I should be on the new account page
    When I fill in "account_name" with "Cash"
    And I select "Asset" from "account_type"
    And I press "Create Account"
    Then I should see "Account was successfully created."
    
Scenario: Successfully show account
    Given I am on the accounts page
    And I Show the first account on the list
    Then I should see "CashTest"
    
Scenario: Successfully delete account
    Given I am on the accounts page
    And I delete the first record in accounts
    Then I should see "Account was successfully destroyed."
    
Scenario: Failing create new empty account
    And I am on the accounts page
    When I follow "New Account"
    Then I should be on the new account page
    When I fill in "account_name" with ""
    And I select "Asset" from "account_type"
    And I press "Create Account"
    Then I should see "Name can't be blank"