module DataMapper
  module NestedAttributesPatch
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def accepts_nested_attributes_for(field, *)
        super
        before "#{field}_attributes=".to_sym do
          self.send("#{field}").each {|child| child.destroy unless child.new? }
          self.send(field).clear
        end
      end
    end
  end
end