class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from Exception, :with => :bad_request! if Rails.env == 'production'

  include ::AuthenticatedSystem
  include ::Traits::Controller::Exceptions
end
