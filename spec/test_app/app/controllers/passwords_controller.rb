# Lets users reset their password when they forgot or when their account was created by an admin.
# origin: RM
class PasswordsController < Clearance::PasswordsController

  public_controller

  private

  # Be more gentle than the default Clearance implementation and redirect
  # users to the password recovery from if the token is incorrect (or already used)
  def forbid_non_existent_user
    super
  rescue ActionController::Forbidden => e
    if User.exists?(params[:user_id])
      redirect_to new_password_path(:user_id => params[:user_id])
    else
      raise e
    end
  end

  def url_after_create
    new_session_path
  end

  def url_after_update
    root_path
  end

  def flash_success_after_update
    nil
  end

end
