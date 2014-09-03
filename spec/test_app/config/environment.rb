# Application-wide settings.
# Be sure to restart your server when you modify this file
# origin: RM

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.11' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

PAGE_SIZE = 50

APPLICATION_TITLE = 'Conferences and Participants'
NO_REPLY_EMAIL = "no-reply@makandra.com"
APPLICATION_EMAIL = NO_REPLY_EMAIL
APPLICATION_HOST = "localhost"

Rails::Initializer.run do |config|

  config.action_mailer.default_url_options = { :host => APPLICATION_HOST }

  config.autoload_paths << "#{RAILS_ROOT}/app/controllers/shared"
  config.autoload_paths << "#{RAILS_ROOT}/app/models/shared"
  
end

I18n.default_locale = "en"
