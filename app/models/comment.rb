class Comment < BaseModel
  # Traits / Modules
  include ::Traits::Model::TextProcessing::Markdown

  # Associations
  belongs_to :author, :class_name => "Person"
  belongs_to :article
  
  # Validations
  validates_presence_of :body_raw
  validates_presence_of :article
  attr_accessible :body_raw

  # Callbacks
  markdown :body_raw => :body
  after_save :increment_article_version
  
protected
  
  def increment_article_version
    article.increment_version
    article.save
  end  
end
