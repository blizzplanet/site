# encoding: utf-8
require 'digest/sha1'
class Person < BaseModel
  # Traits / Modules
  # restful-authentication
  include ::Traits::Model::RestfulAuthentication
  include ::Authentication
  include ::Authentication::ByPassword
  include ::Authentication::ByCookieToken

  # Properties
  property :id,    Serial
  property :login, String, :length => 3..40,  :index => true
  property :name,  String, :length => 100
  property :email, String, :length => 6..100, :index => true
  property :version, Integer, :default => 0

  # Class methods

  # Instance methods
  def greet
    (I18n.t("greetings").sample || "") % {:username => login}
  end

  def display_name
    name.blank? ? login : "#{name} (#{login})"
  end

end
