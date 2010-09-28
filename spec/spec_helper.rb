require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] ||= 'test'

Spork.prefork do
  require File.expand_path("../../config/application", __FILE__)
  Spork.trap_method(Bru::Application, :reload_routes!)
  Spork.trap_method(Bru::Application, :eager_load!)
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
end

Spork.each_run do
  # This code will be run each time you run your specs.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

end





RSpec.configure do |config|
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, comment the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
end
