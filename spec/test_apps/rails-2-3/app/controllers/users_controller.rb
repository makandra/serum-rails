# Provides user sign up, the user status pages and sends friendship requests to individual users.
# origin: RM
class UsersController < ApplicationController

  public_controller :only => [:new, :create]
  
  does 'boring_controller'

  permissions :users
  in_sections :members

  new_action do
    before { set_sections_for_sign_up }
  end

  update do
    flash 'Profile updated'
  end

  create do
    before { set_sections_for_sign_up }
    flash 'Welcome!'
    wants.html do
      sign_in(object)
      redirect_to root_path
    end
  end

  show.before do
    in_sections :profile if object == current_user
  end

  def request_friendship
    object.friendship_requests.create! :requesting_user => current_user if current_user.can_become_friends_with? object
    flash[:notice] = 'Contact requests sent'
    redirect_to object_path
  end

  private

  def set_sections_for_sign_up
    in_sections :sign_up, :exclusive => true
  end

  def object_params
    (super || {}).slice(:username, :email, :password, :password_confirmation, :full_name, :town, :country)
  end

end
