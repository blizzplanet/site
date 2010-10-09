module Traits
  module Model
    module Cachable
      def cache
        Rails.cache
      end

      def cache_key
        result = [self.class.name, id]
        result << updated_at if respond_to?(:updated_at)
        result << version    if respond_to?(:version)
        result << ActiveSupport::SecureRandom.hex(32) if new_record?
        ActiveSupport::Cache.expand_cache_key(result.flatten.compact)
      end

      def save(*)
        increment_version
        super if defined?(super)
      end

      def increment_version
        if respond_to?(:version=)
          self.version = self.version.to_i + 1
        end
      end
    end
  end
end
