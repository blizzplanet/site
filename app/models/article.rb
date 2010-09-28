class Article < BaseModel
  # Traits / Modules
  include ::Traits::Model::Sluggable
  # Assocations
  belongs_to :category

  # Validations
  validates_presence_of :title
  validates_presence_of :body_raw

  # Callbacks

  # Instance methods

  def slug_field
    :title
  end
end
