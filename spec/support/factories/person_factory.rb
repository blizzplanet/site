Factory.define :person do |f|
  f.sequence(:login) {|n| "person-#{n}" }
  f.sequence(:name) {|n| "Person Named Mr.#{n}"}
  f.sequence(:email) {|n| "email#{n}@gmail.com" }
  f.password "SIKRET"
  f.password_confirmation "SIKRET"
end

Factory.define :admin, :parent => :person do |f|
  f.admin true
end


Factory.define :moderator, :parent => :person do |f|
  f.moderator true
end

Factory.define :newsmaker, :parent => :person do |f|
  f.newsmaker true
end

def people_groups
  [:person, :admin, :newsmaker, :moderator]
end