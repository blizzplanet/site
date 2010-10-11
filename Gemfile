source 'http://rubygems.org'

###
# Framework
###
RAILS_VERSION = '~> 3.0.0'

gem 'railties',      RAILS_VERSION
gem 'activemodel',   RAILS_VERSION
gem 'activesupport', RAILS_VERSION
gem 'actionpack',    RAILS_VERSION
gem 'actionmailer',  RAILS_VERSION
gem 'activerecord',  RAILS_VERSION


# gem 'arel',          '~> 1.0.1'
# gem 'mysql2'
###
# ORM
###
REQUIRED_DM_VERSION = '= 1.0.2'

gem 'dm-core',           REQUIRED_DM_VERSION
gem 'dm-types',          REQUIRED_DM_VERSION
gem 'dm-migrations',     REQUIRED_DM_VERSION
gem 'dm-transactions',   REQUIRED_DM_VERSION

gem 'dm-mysql-adapter',  REQUIRED_DM_VERSION, :group => :production
gem 'dm-sqlite-adapter', REQUIRED_DM_VERSION, :group => :test

gem 'dm-rails',          REQUIRED_DM_VERSION
gem 'dm-active_model',   REQUIRED_DM_VERSION
gem 'dm-validations',    REQUIRED_DM_VERSION
gem 'dm-serializer',     REQUIRED_DM_VERSION
gem 'dm-aggregates',     REQUIRED_DM_VERSION
gem 'dm-accepts_nested_attributes', '~> 1.0.0'
gem 'dm-timestamps',     REQUIRED_DM_VERSION
gem 'dm-counter-cache', :git => "git://github.com/markiz/dm-counter-cache.git"
gem 'dm-constraints',    REQUIRED_DM_VERSION
gem 'dm-is-nested_set',  REQUIRED_DM_VERSION
###
# Production
###
gem 'thin'
gem "memcache-client", :require => "memcache"

###
# Miscellaneous
###
gem "rdiscount"
gem "haml", "3.0.18"
gem "formtastic", "~> 1.1.0"

# gem "restful-authentication", :git => "git://github.com/Satish/restful-authentication.git", :branch => "rails3"


###
# Testing
###
group :test do
  gem "rspec"
  gem "rspec-rails"
  gem 'factory_girl'
  gem 'spork'
end
