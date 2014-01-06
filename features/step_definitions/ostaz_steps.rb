# Add a declarative step here for populating the DB with movies.

Given /the following accounts exist/ do |accounts_table|
  accounts_table.hashes.each do |account|
    Account.create! account
  end
end

Given /the following transactions exist/ do |transactions_table|
  transactions_table.hashes.each do |transaction|
    @transaction = Transaction.build(
    :credit => {:account=>transaction[:credit_account],:amount => transaction[:amount]},
    :debit => {:account=>transaction[:debit_account],:amount => transaction[:amount]}
    )
    @transaction.save
    p Transaction.all
  end
end

Given /^I am a new, authenticated "(.*?)"$/ do |role|
  email = role+'@localhost.com'
  password = role+'@localhost.com'
  role = role
  User.new(:email => email, :password => password, :password_confirmation => password, :role=> role).save!

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"

end

Given /^I delete the first record in accounts$/ do
  page.driver.submit :delete, "/accounts/#{Account.first.id}", {}
end

Given /^I delete the first record in transactions$/ do
  page.driver.submit :delete, "/transactions/#{Transaction.first.id}", {}
end