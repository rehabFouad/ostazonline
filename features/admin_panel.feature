Feature: Authorize with various rols

As a System Admin
I want to be able to manage my registerd in users
So that I can reset passwords for a specified user or destroy his account

Background: There is one registered user in the db other than admin

Given the following user exist
  | email            		  | password  	  | role	|
  | test@localhost.com        | password	  | Default |
And all accounts and associated permissions are in place
And I am a new, authenticated "Admin"

Scenario: Successfully authorize Admin
    When I am on the logons page
    	Then I should see "test@localhost.com"
    	And I should see the action "Admin:Reset"
    	And I should see the action "Admin:Destroy"
    		
Scenario: Successfully reset user password
	When I am on the logons page
	And I reset the first record in users
	Then I should see "User password reset completed successfully - new password is 123456."
	
Scenario: Successfully destroy user account
	When I am on the logons page
	And I delete the first record in users
	Then I should see "User was successfully destroyed."
	
	 