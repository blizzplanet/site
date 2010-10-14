module ::Traits::Model::AccessControl::EditableByAuthor
  def self.included(base)
    base.extend ClassMethods
  end
  
  def editable_by?(person)
    (person && author == person) || super
  end
  
  module ClassMethods
    def editable_by(person)
      if person
        all(:author => person) | super
      else
        super
      end
    end    
  end
end