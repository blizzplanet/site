# encoding: utf-8
require 'digest/sha1'

class Person < BaseModel
  # Traits / Modules
  # restful-authentication
  include ::Traits::Model::RestfulAuthentication
  include ::Authentication
  include ::Authentication::ByPassword
  include ::Authentication::ByCookieToken



  # Class methods

  # Instance methods
  def greet
    (I18n.t("greetings").sample || "") % {:username => login}
  end

end
