Factory.define :article do |f|
  f.association :category
  f.title "Hello, world!"
  f.body_raw "Hello, **world**! I am a duck and proud of it."
end