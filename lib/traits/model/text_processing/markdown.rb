module Traits::Model::TextProcessing
  module Markdown
    def self.included(base)
      base.class_eval do
        extend ClassMethods
        cattr_accessor :markdown_fields
        self.markdown_fields = {}
        before_validation :update_markdown_fields
      end
    end

    def update_markdown_fields
      self.class.markdown_fields.each do |raw_field, field|
        self.send("#{field}=", ::RDiscount.new(self.send(raw_field).to_s, :filter_html, :strict, :safelink, :autolink).to_html)
      end
    end

    module ClassMethods
      def markdown(fields = {})
        self.markdown_fields.merge!(fields)
      end
    end
  end
end