Factory.define :category do |f|
  f.sequence(:title) {|n| "Category #{n}"}
  f.parent { Category.count > 0 ? Category.last : nil }
end