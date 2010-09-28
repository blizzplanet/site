Sass::Plugin.options.merge!({
  :template_location => {'app/stylesheets' => 'public/stylesheets'},
  :css_location => 'public/stylesheets',
  :js_location => 'public/javascripts',
  :image_location => 'public/images',
  :image_url => '/images',
  :format => :html5
})