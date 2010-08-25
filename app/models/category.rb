class Category < BaseModel
  # Traits / Modules
  include ::CollectiveIdea::Acts::NestedSet::Base
  acts_as_nested_set

  # Associations                    
  has_many :articles

  # Validations
  validates_presence_of :title
end
