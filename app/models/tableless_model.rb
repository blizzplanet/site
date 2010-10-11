class TablelessModel
  include ::ActiveModel::Validations
  include ::ActiveModel::Conversion
  extend  ::ActiveModel::Naming

  include ::Traits::Model::Attributes::MassAssignment
  
  def persisted?
    false
  end
  
  def new_record?
    !persisted?
  end
  
  def new?
    new_record?
  end
end