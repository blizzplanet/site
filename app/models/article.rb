class Article < BaseModel
  # Traits / Modules
  include ::Traits::Model::Sluggable
  include ::Traits::Model::TextProcessing::Markdown

  # Assocations
  belongs_to :category

  # Validations
  validates_presence_of :title
  validates_presence_of :body_raw

  attr_accessible :title, :body_raw

  # Callbacks
  markdown :body_raw => :body

  # Instance methods

  def slug_field
    :title
  end
end
