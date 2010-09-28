module Traits::Controller::Action
  module Destroy
    
    def self.included(base)
      base.class_eval <<-EOF
        before_filter :find_resource!, :only => [:destroy]
      EOF
    end
    
    def destroy
      @json = resource.to_json
      if destroy_resource
        respond_on_successful_destroy
      else
        respond_on_unsuccessful_destroy
      end
    end
    
  protected
  
    def destroy_resource
      resource.destroy
    end
    
    def respond_on_successful_destroy
      if request.xhr?
        render :json => @json
      else
        redirect_on_destroy
      end
    end
    
    def respond_on_unsuccessful_destroy
      if request.xhr?
        render :json => resource.to_json, :status => :bad_request
      else
        render :new, :status => :bad_request
      end
    end

    def redirect_on_destroy
      redirect_to "/"
    end
  end
end