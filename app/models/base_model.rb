class BaseModel < ActiveRecord::Base
  self.abstract_class = true
  include ::Traits::Model::Cachable  
end