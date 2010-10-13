module ::Traits::Model::AccessControl::Pending::ViewableByNewsmakers
  def self.included(base)
    base.extend ClassMethods
  end
  
  def viewable_by?(person)
    (!approved? && person && person.newsmaker?) || super
  end
  
  module ClassMethods
    def viewable_by(person)
      if person && person.newsmaker?
        all(:approved => false) | super
      else
        super
      end
    end    
  end
end