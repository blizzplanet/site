class Category < BaseModel
  # Traits / Modules
  include ::CollectiveIdea::Acts::NestedSet::Base
  acts_as_nested_set
  include ::Traits::Model::Sluggable

  # Associations
  has_many :articles

  # Validations
  validates_presence_of :title

  # Class methods
  def self.main
    titles = ["Starcraft 1", "Starcraft 2", "Diablo 2", "Diablo 3", "Warcraft 3", "World of Warcraft", "Blizzard"]
    Category.where(:title => titles).all
  end

  def self.games
    titles = ["Starcraft 1", "Starcraft 2", "Diablo 2", "Diablo 3", "Warcraft 3", "World of Warcraft"]
    Category.where(:title => titles).all
  end

  # Instance methods
  def children_articles
    Article.where(:category_id => self_and_descendants).joins(:category).order(Article.arel_table[:id].desc).limit(10).all
  end

  def slug_field
    :title
  end

  def to_param
    slug
  end

end
