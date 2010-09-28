module Traits::Controller
  module Resource
    def self.included(base)
      resource_class = begin
        base.resource_class
      rescue
        nil
      end

      if !resource_class
        base.class_eval <<-EOF
          protected
          def self.resource_class
            @resource_class ||= name.demodulize.match(/(.*)Controller/)[1].singularize.constantize
          end
        EOF
      else
        base.class_eval <<-EOF
          protected
          def self.resource_class
            @resource_class ||= #{resource_class}
          end
        EOF
      end
      base.class_eval <<-EOF
        protected
        def self.resource_name
          @resource_name ||= resource_class.to_s.tableize.singularize
        end

        def self.resource_identifier
          @resource_identifier ||= resource_name.to_sym
        end

        def self.resource_key
          @resource_key ||= resource_class.primary_key.to_sym
        end

        def resources=(new_value)
          instance_variable_set("@" + self.resource_name.pluralize, new_value)
        end

        def resources
          instance_variable_get("@" + self.resource_name.pluralize)
        end

        def resource=(new_value)
          instance_variable_set("@" + self.resource_name, new_value)
        end

        def resource
          instance_variable_get("@" + self.resource_name)
        end


        attr_accessor self.resource_name
        attr_accessor self.resource_name.pluralize

        public
      EOF
    end

    protected

    def resource_class
      self.class.resource_class
    end

    def resource_name
      self.class.resource_name
    end

    def resource_identifier
      self.class.resource_identifier
    end

    def resource_scope
      resource_class.scoped
    end

    def new_resource_attributes
      params[resource_identifier] || {}
    end

    def resource_key
      self.class.resource_key
    end

    def build_resource
      self.resource = resource_class.new(new_resource_attributes)
    end

    def update_resource
      self.resource.attributes = new_resource_attributes
    end

    def fetch_resource(options = {})
      resource_scope.where(fetch_resource_options.merge(resource_key => params[:id]).merge(options)).first
    end

    def fetch_resource_options
      {}
    end

    def fetch_resource!
      fetch_resource || not_found!
    end

    def find_resource
      self.resource = fetch_resource
    end

    def find_resource!
      find_resource || not_found!
    end

    def fetch_resources(options = {})
      resource_scope.where((fetch_resources_options.merge(options))).all
    end

    def fetch_resources_options
      {}
    end

    def find_resources(options = {})
      self.resources = fetch_resources(options)
    end

    def not_found!
      super if defined?(super)
    end
  end
end