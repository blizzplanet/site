module ::Traits::Model::AccessControl::EditableByModerators
  def self.included(base)
    base.extend ClassMethods
  end
  
  def editable_by?(person)
    (person && person.moderator?) || super
  end
  
  module ClassMethods
    def editable_by(person)
      if person && person.moderator?
        all | super
      else
        super
      end
    end    
  end
end