module ::Traits::Model::AccessControl::Groups::Newsmaker
  def self.included(base)
    base.class_eval do 
      property :newsmaker, ::DataMapper::Property::Boolean, :default => false
    end
  end
  
  def groups
    super + (self.newsmaker? ? [:newsmaker] : [])
  end  
end