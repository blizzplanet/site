class ApplicationController < ActionController::Base
  protect_from_forgery

  include ::AuthenticatedSystem
  include ::Traits::Controller::Exceptions
end
