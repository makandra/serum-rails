# Provides authorization, authentication and CSRF protections for controllers.
# origin: RM
module ApplicationController::SecurityTrait

  as_trait do

    include Aegis::Controller
    include Clearance::Authentication
    protect_from_forgery
    filter_parameter_logging :password

    # Require a signed in user by default
    before_filter :authenticate
    around_filter :rescue_access_denied

    require_permissions

    private

    # Override Clearance method so people not signed in are still users
    def current_user
      super || User.guest
    end

    # Override Clearance method for our notion of being signed in
    def signed_in?
      super && current_user != User.guest
    end

    # Override Clearance method for our notion of being signed in
    def signed_out?
      !signed_in?
    end

    # Override Clearance method so sessions time out after 1 hour 
    def sign_in(user)
      if user
        cookies[:remember_token] = {
          :value   => user.remember_token,
          :expires => 1.hour.from_now.utc
        }
        self.current_user = user
      end
    end

    def rescue_access_denied
      yield
    rescue Aegis::AccessDenied => e
      flash[:error] = 'Access denied'
      redirect_to root_path
    end

    # Mark a controller that doesn''t require a signed in user
    def self.public_controller(options = {})
      skip_permissions
      skip_before_filter :authenticate, options
    end
    
    def sign_in_url
      new_session_path
    end

  end

end
