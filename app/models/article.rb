class Article < BaseModel
  # Traits / Modules
  include ::Traits::Model::Sluggable
  include ::Traits::Model::TextProcessing::Markdown

  # Assocations
  belongs_to :category
  belongs_to :author, :class_name => "Person"
  # Validations
  validates_presence_of :title
  validates_presence_of :body_raw
  validates_presence_of :category

  attr_accessible :title, :body_raw, :category_id

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
      when /diablo/i
        "diablo"
      when /starcraft/i
        "starcraft"
      else
        "blizzard"
    end
  end

  def extract
    body_raw.split(".")[0..1].map {|b| b + "."}.join("")[0..99]
  end

  def slug_field
    :title
  end

  def to_param
    slug
  end
end
