class TablelessModel
  include ::ActiveModel::Validations
  include ::ActiveModel::Conversion
  extend  ::ActiveModel::Naming

  include ::Traits::Model::Attributes::MassAssignment
  
  def new_record?
    true
  end
end