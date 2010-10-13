module ::Traits::Model::AccessControl::Approvable
  def self.included(base)
    base.class_eval do
      extend ClassMethods
      property :approved, ::DataMapper::Property::Boolean, :default => false
    end
  end
  
  def pending?
    !approved?
  end
    
  def approvable_by?(person)
    false
  end
  
  def unapprovable_by?(person)
    approvable_by?(person)
  end

  def approve!
    self.approved = true
    self.save
  end

  def unapprove!
    self.approved = false
    self.save
  end
  
  module ClassMethods
    def approvable_by(person)
      self.all(:limit => 0)
    end
  end
end