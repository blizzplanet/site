module ::Traits::Model::AccessControl::Pending::ApprovableByNewsmakers
  def self.included(base)
    base.extend ClassMethods
  end
  
  def approvable_by?(person)
    (person && person.newsmaker?) || super
  end
  
  module ClassMethods
    def approvable_by(person)
      if person && person.newsmaker?
        all(:approved => false) | super
      else
        super
      end
    end    
  end
end