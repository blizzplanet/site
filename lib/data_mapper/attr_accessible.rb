module DataMapper
  class AttrAccessibleException < Exception; end
  module AttrAccessible
    def self.included(base)
      base.extend ClassMethods
      base.class_eval { cattr_accessor :accessible_attributes }
    end

    def attributes=(attributes)
      if attributes.is_a?(Hash) && self.class.accessible_attributes && attributes.keys.all? {|k| k.is_a?(Symbol) || k.is_a?(String) }
        attributes.keys.map(&:to_sym).each do |key|
          raise AttrAccessibleException, "#{key} is not accessible in #{self.class.name}" unless self.class.accessible_attributes.include?(key)
        end
      end
      super
    end

    module ClassMethods
      def attr_accessible(*attrs)
        self.accessible_attributes ||= []
        self.accessible_attributes.push(*attrs)
      end
    end

  end
end