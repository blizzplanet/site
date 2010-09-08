module Traits::Model::Attributes::MassAssignment
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do

    end
  end

  def initialize(attributes = {}, *)
    self.attributes = attributes
    super
  end

  def attributes=(attributes = {})
    ActiveSupport::HashWithIndifferentAccess.new(attributes).each do |key, value|
      self.send("#{key}=", value) if accessible?(key)
    end
  end

  def accessible?(key)
    self.respond_to?("#{key}=") && (self.class.accessible_attributes.nil? || self.class.accessible_attributes.include?(key.to_s))
  end

  module ClassMethods
    attr_accessor :accessible_attributes
    def attr_accessible(*attributes)
      self.accessible_attributes = [attributes].flatten.compact.map(&:to_s)
    end


  end
end