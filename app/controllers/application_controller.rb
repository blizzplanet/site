class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from Exception, :with => :not_found

  include ::AuthenticatedSystem
  include ::Traits::Controller::Exceptions
end
