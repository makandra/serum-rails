# Accepts or rejects a friendship request.
# origin: M
class FriendshipRequestsController < ApplicationController

  permissions :friends

  def accept
    if object.accept
      flash[:notice] = 'Contact request accepted'
    else
      flash[:error] = 'Error accepting contact request'
    end
    redirect_to current_user
  end

  def deny
    if object.deny
      flash[:notice] = 'Contact request denied'
    else
      flash[:error] = 'Error denying contact request'
    end
    redirect_to current_user
  end
  
  private

  def object
    @friendship_request ||= current_user.friendship_requests.find(params[:id])
  end

end
