# Base class for all webservice controllers; defines common functionality like authorization.
# origin: M
class Ws::ApiController < ActionController::Base

  does 'ws/api_controller/parsers'
  does 'ws/api_controller/formatters'

  before_filter :authenticate
  before_filter :deny_guest
  around_filter :rescue_exceptions

  attr_reader :api_user

  def json_params
    unless @json_params
      @json_params = params.dup
      @json_params.delete(:controller)
      @json_params.delete(:action)
      @json_params
    end
    @json_params
  end

  def validate_version!(record, version)
    unless record.updated_at.to_i.to_s == version
      raise ActiveRecord::StaleObjectError
    end
  end

  def self.public_actions(*actions)
    skip_before_filter :deny_guest, :only => actions
  end

  def render_no_content
    render :status => 204, :text => ''
  end

  def render_not_implemented
    render :status => 501, :text => ''
  end

  private

  def rescue_exceptions
    yield
  rescue Aegis::AccessDenied
    render :status => '403', :text => ''
  rescue ActiveRecord::RecordNotFound
    render :status => '404', :text => ''
  rescue ActiveRecord::StaleObjectError
    render :status => '409', :text => ''
  rescue => exception
    render :status => '400', :text => ''
  end

  def authenticate
    authenticate_with_http_basic do |username, password|
      @api_user = api_user_from_credentials(username, password)
    end
    true
  end

  def deny_guest
    request_http_basic_authentication('CaP Webservice') unless api_user
  end

  def api_user_from_credentials(username, password)
    User.authenticate(username, password)
  end
end
