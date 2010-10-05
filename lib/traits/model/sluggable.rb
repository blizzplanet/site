module Traits
  module Model
    module Sluggable
      def self.included(base)
        base.class_eval do
          before_validation :generate_slug
          validates_presence_of :slug
        end
      end


      protected
      def slug_scope
        self.class.scoped
      end

      def slug_field
        :name
      end

      def slug_prefix
        ""
      end

      def generate_slug
        if send(slug_field)
          self.base_slug = slug_prefix + self.send(slug_field).transliterated
          self.base_slug = base_slug.gsub(/[^a-zA-Z0-9]+/, "-").gsub(/-+$/, "").downcase
          self.slug = base_slug + slug_first_available_suffix
          slug
        end
      end

      def slug_first_available_suffix
        scope = slug_scope
        scope = scope.where(:base_slug => "#{base_slug}")
        scope = scope.where(self.class.arel_table[:id].lt(id)) if persisted?
        slug_count = scope.count
        slug_count > 0 ? "--#{slug_count}" : ""
      end
    end
  end
end