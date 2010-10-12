class Comment < BaseModel
  # Traits / Modules
  include ::Traits::Model::TextProcessing::Markdown
  
  # Properties
  property :id,         Serial
  property :body_raw,   Text
  property :body,       Text
  property :version,    Integer, :default => 0
  property :created_at, DateTime

  # Associations
  belongs_to :author, "Person", :required => false
  belongs_to :article
  
  # Validations
  validates_presence_of :body_raw
  validates_presence_of :article
  attr_accessible :body_raw

  # Callbacks
  markdown :body_raw => :body
  after :save, :increment_article_version
  
protected
  
  def increment_article_version
    article.increment_version
    article.save
  end  
end
