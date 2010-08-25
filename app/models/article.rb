class Article < BaseModel
  # Assocations
  belongs_to :category
  # Validations
  validates_presence_of :title
  validates_presence_of :body_raw
end
