require 'yaml'

yaml = YAML.load(File.read(File.join(File.dirname(File.expand_path(__FILE__)), "seeds.yml")))

def add_category(title, children = nil)
  category = Category.where(:title => title).first || Category.create(:title => title)
  case children
    when Hash
      children.each do |other_title, other_children|
        category.children << add_category(other_title, other_children)
      end
    when Array
      children.each do |other_title|
        category.children << add_category(other_title, [])
      end
  end
  category
end

add_category("articles", yaml["categories"])
