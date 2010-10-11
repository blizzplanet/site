module DataMapper
  module NullablePatch
    include Chainable
    def nullable(*attrs)
      options = attrs.extract_options!.reverse_merge(:chainable => true)
      attrs.each do |attr|

        block = proc do
          define_method "#{attr}=" do |value|
            (value.is_a?(String) && value.empty?) ? super(nil) : super(value)
          end
        end

        if options[:chainable]
          chainable(&block)
        else
          class_eval(&block)
        end
      end
    end
  end
end