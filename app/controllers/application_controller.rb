class ApplicationController < ActionController::Base
  protect_from_forgery
  # rescue_from Exception, :with => :bad_request!

  include ::AuthenticatedSystem
  include ::Traits::Controller::Exceptions
end
