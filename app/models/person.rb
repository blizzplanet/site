require 'digest/sha1'

class Person < BaseModel
  # restful-authentication
  include ::Traits::Model::RestfulAuthentication
  include ::Authentication
  include ::Authentication::ByPassword
  include ::Authentication::ByCookieToken


  protected
    


end
