class ApplicationController < ActionController::Base
  protect_from_forgery
  if Rails.env.production?
    rescue_from Exception do |e|
      Rails.logger.error "\n#{e.inspect}\n#{e.backtrace.join("\n")}\n\n\n"
      bad_request!
    end
  end
  
  include ::AuthenticatedSystem
  include ::Traits::Controller::Exceptions
end
