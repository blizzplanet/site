require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] = 'test'

Spork.prefork do
  require File.expand_path("../../config/application", __FILE__)
  Spork.trap_class_method(Rails::DataMapper, :preload_models)
  Spork.trap_method(Bru::Application, :reload_routes!)
  Spork.trap_method(Bru::Application, :eager_load!)
  require File.expand_path("../../config/environment", __FILE__)
  require 'factory_girl'
  require 'rspec/rails'
  require 'monkey_patches'
  require 'authenticated_test_helper'
  RSpec.configure do |config|
    config.mock_with :rspec
    config.around(:each) do |example|
      DataMapper::Transaction.new(DataMapper.repository).commit do |t|
        example.run
        t.rollback
      end
    end
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  DataMapper.auto_migrate!
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

end