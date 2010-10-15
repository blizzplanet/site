module Traits
  module Model
    module Cachable
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      def cache
        Rails.cache
      end

      def cache_key
        result = [self.class.name, id]
        result << updated_at if respond_to?(:updated_at)
        result << version    if respond_to?(:version)
        result << ActiveSupport::SecureRandom.hex(32) if new?
        ActiveSupport::Cache.expand_cache_key(result.flatten.compact)
      end

      def save(*)
        increment_version
        super if defined?(super)
      end

      def destroy(*)
        self.class.increment_version
        super if defined?(super)
      end

      def increment_version
        if respond_to?(:version=)
          self.version = self.version.to_i + 1
        end
        self.class.increment_version
      end
      
      module ClassMethods
        def cache_key
          result = [self.name]
          result << self.class_cache.version
          ActiveSupport::Cache.expand_cache_key(result.flatten.compact)
        end

        def class_cache
          ClassCache.first_or_create(:class_name => name)
        end
        
        def increment_version
          class_cache.update(:version => class_cache.version + 1)
        end
      end
    end
  end
end
