# Shows the user list, searches users and sends friendship requests to multiple users at once.
# origin: M
class MembersController < ApplicationController

  permissions :members
  in_sections :members, :member_search

  def index
    @member_search ||= MemberSearch.new current_user, params[:member_search]
    @matching_users = @member_search.users.by_username.paginate(:page => params[:page], :per_page => PAGE_SIZE)
  end

  def request_friendships
    for user in User.active.scoped(:conditions => { :id => params[:friendship_request].andand[:user_id] })
      user.friendship_requests.create! :requesting_user => current_user
    end
    flash[:notice] = 'Contact requests sent'
    redirect_to members_path
  end

end
