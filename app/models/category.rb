class Category < BaseModel
  # Traits / Modules
  is_nested_set
  include ::Traits::Model::Sluggable
  # Properties
  property :id, Serial
  property :title,     String
  property :base_slug, String
  property :slug,      String, :index => true
  property :version,   Integer, :default => 0
  # Associations
  has n, :articles

  # Validations
  validates_presence_of :title

  # Class methods
  def self.main
    titles = ["Starcraft 1", "Starcraft 2", "Diablo 2", "Diablo 3", "Warcraft 3", "World of Warcraft", "Blizzard"]
    Category.all(:title => titles)
  end

  def self.games
    titles = ["Starcraft 1", "Starcraft 2", "Diablo 2", "Diablo 3", "Warcraft 3", "World of Warcraft"]
    Category.all(:title => titles)
  end

  def self.drop_caches
    Category.each {|c| c.increment_version; c.save }
  end

  # Instance methods
  def children_articles
    Article.all(:category => self_and_descendants, :order => :id.desc, :limit => 10)
  end

  def slug_field
    :title
  end

  def to_param
    slug
  end

end
