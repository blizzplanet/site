module ::Traits::Model::AccessControl::Viewable
  def self.included(base)
    base.extend ClassMethods
  end
  
  def viewable_by?(person)
    false
  end  
  
  module ClassMethods
    def viewable_by(person)
      all(:limit => 0)
    end
  end
end