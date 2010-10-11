class BaseModel
  def self.inherited(base)
    base.class_eval do
      extend ::ActiveModel::Naming  
      extend ::DataMapper::NullablePatch
      include ::DataMapper::Resource
      include ::DataMapper::ValidationsPatch
      include ::DataMapper::SerializationPatch
      include ::DataMapper::AttrAccessible
      
      include ::Traits::Model::Cachable
    end
  end
end