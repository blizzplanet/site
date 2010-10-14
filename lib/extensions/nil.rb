# nil is a perfectly valid user for our application :)
class NilClass
  include ::Traits::Model::AccessControl::Groups  
end