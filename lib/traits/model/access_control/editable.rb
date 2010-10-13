module ::Traits::Model::AccessControl::Editable
  def self.included(base)
    base.extend ClassMethods
  end
  
  def editable_by?(person)
    false
  end  
  
  module ClassMethods
    def editable_by(person)
      self.all(:limit => 0)
    end
  end
end