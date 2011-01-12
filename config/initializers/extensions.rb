Dir.glob("#{Rails.root}/lib/extensions/**/*.rb").each do |ext|
  require File.expand_path(ext)
end