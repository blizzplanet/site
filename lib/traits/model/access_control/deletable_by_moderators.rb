module ::Traits::Model::AccessControl::DeletableByModerators
  def self.included(base)
    base.extend ClassMethods
  end
  
  def deletable_by?(person)
    (person && person.moderator?) || super
  end
  
  module ClassMethods
    def deletable_by(person)
      if person && person.moderator?
        all | super
      else
        super
      end
    end    
  end
end