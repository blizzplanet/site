Factory.define :person do |f|
  f.sequence(:login) {|n| "person-#{n}" }
  f.sequence(:name) {|n| "Person Named Mr.#{n}"}
  f.sequence(:email) {|n| "email#{n}@gmail.com" }
  f.password "SIKRET"
  f.password_confirmation "SIKRET"

end