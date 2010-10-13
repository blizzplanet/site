class ClassCache
  include ::DataMapper::Resource
  
  property :id,         Serial
  property :class_name, String, :index => true
  property :version,    Integer, :default => 0
end