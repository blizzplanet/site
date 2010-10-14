module ::Traits::Model::AccessControl::Pending::ViewableByAuthor
  def self.included(base)
    base.extend ClassMethods
  end
  
  def viewable_by?(person)
    (!approved? && person && person == author) || super
  end
  
  module ClassMethods
    def viewable_by(person)
      if person
        all(:approved => false, :author => person) | super
      else
        super
      end
    end    
  end
end