module Traits::Controller::Action
  module Update
    
    def self.included(base)
      base.class_eval <<-EOF
        before_filter :find_resource!, :only => [:edit, :update]
      EOF
    end
    
    def update
      update_resource
      if save_resource
        respond_on_successful_update
      else
        respond_on_unsuccessful_update
      end
    end
    
  protected
  
    def save_resource
      resource.save
    end
    
    def respond_on_successful_update
      redirect_on_update
    end
    
    def respond_on_unsuccessful_update
      if request.xhr?
        render :json => resource.to_json(:methods => [:errors])
      else
        render :edit, :status => :bad_request
      end
    end

    def redirect_on_update
      redirect_to successful_update_url
    end
    
    def successful_update_url
      resource
    end
  end
end