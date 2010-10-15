module ::Traits::Model::AccessControl::ViewableByAll
  def self.included(base)
    base.extend ClassMethods
  end
  
  def viewable_by?(person)
    true
  end
  
  module ClassMethods
    def viewable_by(person)
      all | super
    end    
  end
end