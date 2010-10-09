class Article < BaseModel
  # Traits / Modules
  include ::Traits::Model::Sluggable
  include ::Traits::Model::TextProcessing::Markdown

  # Assocations
  belongs_to :category
  belongs_to :author, :class_name => "Person"
  has_many :comments
  # Validations
  validates_presence_of :title
  validates_presence_of :body_raw
  validates_presence_of :category

  attr_accessible :title, :body_raw, :short_version, :category_id

  # Callbacks
  markdown :body_raw => :body

  # Class methods
  def self.recent
    order(arel_table[:created_at].desc).joins(:category).limit(5)
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
