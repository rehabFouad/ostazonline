# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Cleaning all models ......"

User.destroy_all
Account.destroy_all
Transaction.destroy_all
Amount.destroy_all

puts "All models truncated, Seeding ....."

users = User.create([
  {email: 'admin@ostazonline.herokuapp.com',      password: '123456', password_confirmation: '123456', role: 'Admin'},
  {email: 'accountant@ostazonline.herokuapp.com', password: '123456', password_confirmation: '123456', role: 'Accountant'},
  {email: 'observer@ostazonline.herokuapp.com',   password: '123456', password_confirmation: '123456', role: 'Observer'},
  {email: 'entry@ostazonline.herokuapp.com',      password: '123456', password_confirmation: '123456', role: 'Entry'}
  ])
puts "#{User.count} users were create successfully"

permissions = Permission.create([
  {:user_id => User.find_by_role("Admin").id,:name => "Admin", :action => "manage", :subject_class =>"all"},
  {:user_id => User.find_by_role("Accountant").id,:name => "Accountant", :action => "manage", :subject_class =>"Account"},
  {:user_id => User.find_by_role("Accountant").id,:name => "Accountant", :action => "manage", :subject_class =>"Transaction"},
  {:user_id => User.find_by_role("Accountant").id,:name => "Accountant", :action => "read", :subject_class =>"all"},
  {:user_id => User.find_by_role("Observer").id,:name => "Observer", :action => "read", :subject_class =>"all"}
])
puts "#{User.count} rols were create successfully"

accounts = Account.create([
  {name: 'Cash',              type: 'Asset'},
  {name: 'Bank',              type: 'Asset'},
  {name: 'Capital',           type: 'Equity'},
  {name: 'Office Expenses',   type: 'Expense'},
  {name: 'Accounts Payable',  type: 'Liability'}
  ])
puts "#{Account.count} accounts were create successfully"
  
transaction = Transaction.build({
    description: 'Initial Amount',
    credit:{account: 'Capital', amount: 10000.0},
    debit: {account: 'Bank',     amount: 10000.0}
    })
transaction.save
transaction = Transaction.build({
    description: 'Expense',
    credit:{account: 'Bank', amount: 500.0},
    debit: {account: 'Office Expenses',amount: 500.0}
    })
transaction.save
puts "#{Transaction.count} transaction was create successfully"
