module ::Traits::Model::AccessControl::DeletableByNewsmakers
  def self.included(base)
    base.extend ClassMethods
  end
  
  def deletable_by?(person)
    (person && person.newsmaker?) || super
  end
  
  module ClassMethods
    def deletable_by(person)
      if person && person.newsmaker?
        all | super
      else
        super
      end
    end    
  end
end