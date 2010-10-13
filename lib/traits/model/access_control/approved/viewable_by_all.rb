module ::Traits::Model::AccessControl::Approved::ViewableByAll
  def self.included(base)
    base.extend ClassMethods
  end
  
  def viewable_by?(person)
    approved? || super
  end
  
  module ClassMethods
    def viewable_by(person)
      all(:approved => true) | super
    end    
  end
end