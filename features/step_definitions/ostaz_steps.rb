# Add a declarative step here for populating the DB with movies.
Given /^all accounts and associated permissions are in place$/ do
users = User.create([
{email: 'admin@ostazonline.herokuapp.com',      password: '123456', password_confirmation: '123456', role: 'Admin'},
{email: 'accountant@ostazonline.herokuapp.com', password: '123456', password_confirmation: '123456', role: 'Accountant'},
{email: 'observer@ostazonline.herokuapp.com',   password: '123456', password_confirmation: '123456', role: 'Observer'},
{email: 'entry@ostazonline.herokuapp.com',      password: '123456', password_confirmation: '123456', role: 'Entry'}
])

permissions = Permission.create([
  {:user_id => User.find_by_role("Admin").id,:name => "Admin", :action => "manage", :subject_class =>"all"},
  {:user_id => User.find_by_role("Accountant").id,:name => "Accountant", :action => "manage", :subject_class =>"Account"},
  {:user_id => User.find_by_role("Accountant").id,:name => "Accountant", :action => "manage", :subject_class =>"Transaction"},
  {:user_id => User.find_by_role("Accountant").id,:name => "Accountant", :action => "read", :subject_class =>"all"},
  {:user_id => User.find_by_role("Observer").id,:name => "Observer", :action => "read", :subject_class =>"all"}
])
end

Given(/^the following user exist$/) do |table|
  table.hashes.each do |user|
    User.new(:email => user[:email], :password => user[:password], :password_confirmation => user[:password], :role=> user[:role]).save!
  end
end

Given /the following accounts exist/ do |accounts_table|
  accounts_table.hashes.each do |account|
    Account.create! account
  end
end

Given /the following transactions exist/ do |transactions_table|
  transactions_table.hashes.each do |transaction|
    @transaction = Transaction.build(
    :description => transaction[:description],
    :credit => {:account=>transaction[:credit_account],:amount => transaction[:amount]},
    :debit => {:account=>transaction[:debit_account],:amount => transaction[:amount]}
    )
    @transaction.save
  end
end

Given /^I am a new, authenticated "(.*?)"$/ do |role|
  email = role+'@ostazonline.herokuapp.com'
  password = "123456"

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"
  
end

Given /^I reset the first record in users$/ do
  page.driver.submit :put, "/logon/#{User.first.id}", {}
end

Given /^I delete the first record in users$/ do
  page.driver.submit :delete, "/logon/#{User.first.id}", {}
end

Given /^I delete the first record in accounts$/ do
  page.driver.submit :delete, "/accounts/#{Account.first.id}", {}
end

Given /^I delete the first record in transactions$/ do
  page.driver.submit :delete, "/transactions/#{Transaction.first.id}", {}
end

Then /^I should see the alt text "([^\"]*)"$/ do | alt_text |
  assert page.has_xpath?("//img[@alt=#{alt_text}]")
end

Then /^I should (not )?see the action "([^"]*)"$/ do |negate, selector|
  bu = {
    "Account:Show"=>"td:nth-child(5) img", 
    "Account:Destroy"=>"td:nth-child(6) img", 
    "Transaction:Destroy"=>"td:nth-child(7) img",
    "Admin:Reset"=>"td:nth-child(5) img",
    "Admin:Destroy"=>"td:nth-child(6) img"
    }
  if(negate)
    assert !page.has_css?(bu[selector])
  else
    assert page.has_css?(bu[selector])
  end
end

Given /^I Show the first account on the list$/ do
  page.driver.submit :get, "/accounts/#{Account.first.id}", {}
end