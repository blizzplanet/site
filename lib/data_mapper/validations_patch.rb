module DataMapper
  module ValidationsPatch
    def self.included(base)
      base.extend ClassMethods
    end

    def save(*)
      return false unless all_valid?
      super
    end

    def all_valid?(*args)
      valid_parents?(*args) && valid?(*args) && valid_children?(*args)
    end

    protected
    def valid_parents?(*args)
      parent_relationships.map do |relationship|
        parent = relationship.get!(self)
        result = parent.valid?(*args)
        parent.errors.to_hash.each {|_, field_errors| field_errors.each {|e| errors.add(relationship.name, e)} }
        result
      end.all?
    end

    def valid_children?(*args)
      child_relationships.map do |relationship|
        result = true
        relationship.get_collection(self).each do |child|
          result &&= child.valid?(*args)
          child.errors.to_hash.each {|_, field_errors| field_errors.each {|e| errors.add(relationship.name, e)} }
        end        
        result
      end.all?
    end

    module ClassMethods
      def before_validation(*args, &block)
        before :valid?, *args, &block
      end
    end
  end
end