module ::Traits::Model::AccessControl::Groups::Moderator
  def self.included(base)
    base.class_eval do 
      property :moderator, ::DataMapper::Property::Boolean, :default => false
    end
  end
end