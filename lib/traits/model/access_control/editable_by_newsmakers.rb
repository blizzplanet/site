module ::Traits::Model::AccessControl::EditableByNewsmakers
  def self.included(base)
    base.extend ClassMethods
  end
  
  def editable_by?(person)
    (person && person.newsmaker?) || super
  end
  
  module ClassMethods
    def editable_by(person)
      if person && person.newsmaker?
        all | super
      else
        super
      end
    end    
  end
end