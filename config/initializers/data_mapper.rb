module DataMapper
  module Validations
    class ValidationErrors
      def to_json(*args)
        as_json(*args).to_json
      end
    end
  end

  class Query
    module Conditions
      class AbstractComparison
        def value
          # was: dumped_value
          loaded_value
        end
      end
    end
  end
end

module ActiveSupport
  module DataMapperReloader
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      #
      # Short explanation to that code-wtf:
      # 1. Datamapper requires you to run DataMapper.finalize after you define all your models
      # 2. Rails in development and test environment doesn't cache classes
      # 3. "not caching classes" means they get unloaded every now and then
      # 4. DataMapper.finalize should better be called once for every unload
      # 5. We force rails to reload our models right after their unloading
      # 6. ... and after that we launch finalization
      # 7. That sucks
      # It is probably a datamapper issue rather than rails's
      #
      def remove_unloadable_constants!(*)
        result = super
        [Category, Person, Article, Comment] # forcing to reload

        DataMapper.finalize

        result
      end
    end
  end

  module Dependencies
    include DataMapperReloader
  end
end