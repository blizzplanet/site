module ::Traits::Model::AccessControl::Groups::Admin
  def self.included(base)
    base.class_eval do 
      property :admin, ::DataMapper::Property::Boolean, :default => false
    end
  end
end