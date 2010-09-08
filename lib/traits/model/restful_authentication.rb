# TODO: write a normal spec set for people

module Traits::Model::RestfulAuthentication
  def self.included(base)
    base.class_eval do
      validates :login, :presence   => true,
                        :uniqueness => true,
                        :length     => { :within => 3..40 },
                        :format     => { :with => Authentication.login_regex, :message => Authentication.bad_login_message }

      validates :name,  :format     => { :with => Authentication.name_regex, :message => Authentication.bad_name_message },
                        :length     => { :maximum => 100 },
                        :allow_nil  => true

      validates :email, :presence   => true,
                        :uniqueness => true,
                        :format     => { :with => Authentication.email_regex, :message => Authentication.bad_email_message },
                        :length     => { :within => 6..100 }
      attr_accessible :login, :email, :name, :password, :password_confirmation

      # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
      def self.authenticate(login, password)
        return nil if login.blank? || password.blank?
        u = find_by_login(login.downcase) # need to get the salt
        u && u.authenticated?(password) ? u : nil
      end
    end
  end


  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
end