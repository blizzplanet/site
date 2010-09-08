# Stub for Session. Tableless
class Session
  include ::ActiveModel::Validations
  include ::ActiveModel::Conversion
  extend  ::ActiveModel::Naming

  include ::Traits::Model::Attributes::MassAssignment

  attr_accessor   :login, :password, :remember_me
  attr_accessible :login, :remember_me

  def persisted?
    false
  end
end