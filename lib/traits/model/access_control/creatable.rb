module ::Traits::Model::AccessControl::Creatable
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def creatable_by?(person)
      false
    end
  end
end