# Sign in and sign out.
# origin: RM
class SessionsController < Clearance::SessionsController

  public_controller

  private
  
  def url_after_create
    root_path
  end

  def flash_success_after_create
    nil
  end

end
