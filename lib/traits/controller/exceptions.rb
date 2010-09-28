module Traits::Controller::Exceptions  
  def forbidden!
    render "status/forbidden",   :status => :forbidden
  end

  def bad_request!
    render "status/bad_request", :status => :bad_request
  end

  def not_found!
    render "status/not_found",   :status => :not_found
  end
end