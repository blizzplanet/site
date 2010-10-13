class Article < BaseModel
  # Traits / Modules
  include ::Traits::Model::Sluggable
  include ::Traits::Model::TextProcessing::Markdown
  
  include ::Traits::Model::AccessControl::Approvable
  include ::Traits::Model::AccessControl::Viewable
  include ::Traits::Model::AccessControl::Approved::ViewableByAll
  include ::Traits::Model::AccessControl::Pending::ApprovableByNewsmakers
  include ::Traits::Model::AccessControl::Pending::ViewableByNewsmakers
  
  # Properties
  property :id,            Serial
  property :body_raw,      Text
  property :body,          Text
  property :short_version, Text
  property :title,         String,  :length => 5..100
  property :base_slug,     String,  :length => 0..250, :allow_nil => true
  property :slug,          String,  :length => 0..250, :allow_nil => true, :index => true
  property :version,       Integer, :default => 0
  property :created_at,    DateTime

  # Assocations
  belongs_to :category,                   :required => false
  belongs_to :author, "Person",           :required => false
  has n, :comments
  # Validations
  validates_presence_of :title
  validates_presence_of :body_raw
  validates_presence_of :category

  attr_accessible :title, :body_raw, :short_version, :category_id

  # Callbacks
  markdown :body_raw => :body

  # Class methods
  def self.recent
    all(:order => :created_at.desc, :limit => 5)
  end

  # Instance methods
  def icon
    return "blizzard" unless category
    case category.title
      when /wow/i
        "wow"
      when /world of warcraft/i
        "wow"
      when /diablo 3/i
        "diablo3"
      when /diablo 2/i
        "diablo2"
      when /diablo/i
        "diablo"
      when /starcraft 2/i
        "starcraft2"
      when /starcraft/i
        "starcraft"
      when /warcraft 3/i
        "warcraft3"
      when /warcraft 2/i
        "warcraft2"
      when /warcraft/i
        "warcraft"
      else
        "blizzard"
    end
  end
  
  def extract
    self.short_version.blank? ? body_raw.split(".")[0..1].map {|b| b + "."}.join("")[0..99] : self.short_version
  end

  def slug_field
    :title
  end

  def to_param
    "#{id}--#{slug}"
  end
end
