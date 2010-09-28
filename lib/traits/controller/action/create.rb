module Traits::Controller::Action
  module Create

    def self.included(base)
      base.class_eval <<-EOF
        before_filter :build_resource, :only => [:new, :create]
      EOF
    end

    def create
      if save_resource
        respond_on_successful_create
      else
        respond_on_unsuccessful_create
      end
    end

  protected

    def save_resource
      resource.save
    end

    def respond_on_successful_create
      redirect_on_create
    end

    def respond_on_unsuccessful_create
      if request.xhr?
        render :json => resource.to_json(:methods => [:errors]), :status => :bad_request
      else
        render :new, :status => :bad_request
      end
    end

    def redirect_on_create
      redirect_to successful_create_url
    end

    def successful_create_url
      polymorphic_url resource
    end
  end
end