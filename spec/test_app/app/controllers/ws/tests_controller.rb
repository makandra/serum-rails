# Dummy controller to test some common webservice functionality; only used in specs
# origin: M
class Ws::TestsController < Ws::ApiController

  def index
    render :json => {'foo' => 'bar'}
  end

  def no_access
    raise Aegis::AccessDenied
  end

  def error
    raise "foo"
  end

  public_actions :public

  def public
    render :json => {'foo' => 'bar'}
  end

end
