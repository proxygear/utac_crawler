source "http://rubygems.org"

# Specify your gem's dependencies in utac.gemspec
gemspec
gem "rails"
gem "httparty", :git => 'git://github.com/jnunemaker/httparty.git'
gem 'nokogiri'

group :test do # Testing
  gem 'thin', '1.2.7' #required by foreman
  gem 'eventmachine', '0.12.10'
  gem 'shoulda' # Shoulda
  gem 'rspec'
  gem 'rspec-core'
  gem 'database_cleaner' # Auto clean database
  gem 'rb-fsevent'
  gem 'guard-livereload' # browser reloading
  gem 'guard-rspec'
  gem 'guard-test'
  gem 'growl' #grow notification
  gem 'rspec-mocks'
  gem 'rspec-expectations'
end