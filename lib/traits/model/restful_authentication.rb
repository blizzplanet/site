# TODO: write a normal spec set for people

module Traits::Model::RestfulAuthentication
  def self.included(base)
    base.class_eval do
      validates_presence_of :email
      validates_uniqueness_of :email, :if => :email_present?
      validates_presence_of :login
      validates_uniqueness_of :login, :if => :login_present?
      validates_format_of :login, :with => ::Authentication.login_regex, :message => ::Authentication.bad_login_message
      validates_format_of :name,  :with => ::Authentication.name_regex,  :message => ::Authentication.bad_name_message
      validates_format_of :email, :with => ::Authentication.email_regex, :message => ::Authentication.bad_email_message
    
      attr_accessible :login, :email, :name, :password, :password_confirmation

      # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
      def self.authenticate(login, password)
        return nil if login.blank? || password.blank?
        u = first(:login => login.downcase) # need to get the salt
        u && u.authenticated?(password) ? u : nil
      end
    end
  end


  def login=(value)
    super(value ? value.downcase : nil)
  end

  def email=(value)
    super(value ? value.downcase : nil)
  end
  
  def email_present?
    !email.blank?
  end
  
  def login_present?
    !login.blank?
  end
end