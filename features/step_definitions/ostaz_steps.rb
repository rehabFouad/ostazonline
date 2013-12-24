# Add a declarative step here for populating the DB with movies.

Given /the following accounts exist/ do |accounts_table|
  accounts_table.hashes.each do |account|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Account.create! account

  end
  #flunk "Unimplemented"
end