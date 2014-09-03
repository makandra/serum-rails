# Base class for all controllers.
# origin: RM
class ApplicationController < ActionController::Base
  include Modularity::Does
  does 'application_controller/security'
  does 'application_controller/i18n'
  does 'application_controller/navigation'
  does 'application_controller/security_trait/disabled_clearance_accounts'

  helper :all
  layout 'screen'

end
