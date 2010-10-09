class Comment < BaseModel
  # Traits / Modules
  include ::Traits::Model::TextProcessing::Markdown

  # Associations
  belongs_to :author, :class_name => "Person"
  belongs_to :article
  
  # Validations
  validates_presence_of :body_raw
  attr_accessible :body_raw

  # Callbacks
  markdown :body_raw => :body

end
