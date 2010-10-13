module ::Traits::Model::AccessControl::Deletable
  def self.included(base)
    base.extend ClassMethods
  end
  
  def deletable_by?(person)
    false
  end  
  
  module ClassMethods
    def deletable_by(person)
      self.all(:limit => 0)
    end
  end
end