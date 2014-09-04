# Code to authenticate against a user database.
# origin: RM
module User::AuthenticationTrait
  as_trait do

    include Clearance::User

    validates_length_of :password, :minimum => 3, :allow_blank => true
    validates_format_of :username, :with => /^[a-z][a-z0-9\.\-_öÖüÜäÄß]+$/mi
    validates_uniqueness_of :username, :case_sensitive => false

    does 'flag', :locked, :default => false

    # Allow to login with either email or screen_name
    def self.authenticate(username_or_email, password)
      return nil unless user = find(:first, :conditions => ['email = ? OR username = ?', username_or_email, username_or_email])
      return user if user.authenticated?(password)
    end

    def email_confirmed?
      true
    end

    def account_disabled?
      locked? || deleted?
    end

    def self.guest
      @guest ||= User.new(:role_name => 'guest')
    end

  end
end
