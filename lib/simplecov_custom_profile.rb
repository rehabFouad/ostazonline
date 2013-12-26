require 'simplecov'
SimpleCov.profiles.define 'all_files_profile' do
  add_filter '/test/'
  add_filter '/config/'

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  
end