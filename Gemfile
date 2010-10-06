source 'http://rubygems.org'

# gem 'rails', '3.0.0'
# gem 'rails', :git => 'git://github.com/rails/rails.git'
RAILS_VERSION = '~> 3.0.0'

gem 'railties',      RAILS_VERSION
gem 'activemodel',   RAILS_VERSION
gem 'activesupport', RAILS_VERSION
gem 'actionpack',    RAILS_VERSION
gem 'actionmailer',  RAILS_VERSION
gem 'activerecord',  RAILS_VERSION
gem 'arel',          '~> 1.0.1'
gem 'mysql2'
gem 'sqlite3-ruby', :require => 'sqlite3'

gem 'thin'
gem "memcache-client", :require => "memcache"

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

gem "rdiscount", "~> 1.6.5"
gem "haml", "3.0.18"
gem "formtastic", "~> 1.1.0"

# gem "restful-authentication", :git => "git://github.com/Satish/restful-authentication.git", :branch => "rails3"

group :test do
  gem "rspec"
  gem "rspec-rails"
  gem 'factory_girl'
  gem 'spork'
end
