# Controller to manage users as an admin.
# origin: RM
class Admin::UsersController < ApplicationController

  does 'boring_controller',
    :order => 'users.username',
    :show_is_edit => true

  before_filter :set_sections, :except => :deleted

  in_sections :admin_users
  permissions :admin_users

  def deleted
    in_sections :deleted_users
    @users = User.find(:all, :conditions => { :deleted => true }).paginate(:page => params[:page], :per_page => PAGE_SIZE)
  end
  
  private
  
  def set_sections
    in_sections object.andand.deleted? ? :deleted_users : :active_users
  end

  # What we call User.search with
  def search_args
    [params[:query], current_user]
  end

end
