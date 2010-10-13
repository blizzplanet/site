module ::Traits::Model::AccessControl::CreatableByPeople
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def creatable_by?(person)
      !person.nil? || super
    end
  end
end