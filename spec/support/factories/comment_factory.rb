Factory.define(:comment) do |f|
  f.body_raw "Hello, world!"
  f.association :author,  :factory => :person
  f.association :article
end