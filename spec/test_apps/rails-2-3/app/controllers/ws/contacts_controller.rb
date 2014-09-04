# Controller for /ws/contacts
# origin: M
class Ws::ContactsController < Ws::ApiController

  public_actions :index

  def index
    user = User.find_by_username!(params[:member_id])
    if user == api_user
      contacts = user.contacts
    else
      contacts = user.friends
    end

    if contacts.any?
      render :json => format_users(contacts)
    else
      render_no_content
    end
  end

  def create
    user = User.find_by_username!(params[:member_id])
    positive = !!(json_params['positive'] or json_params['positive'] == 'true')
    case api_user.status_towards(user)
    when 'RCD_received'
      request = api_user.friendship_requests.find(:first, :conditions => {:requesting_user_id => user.id})
      if positive
        request.accept
      else
        request.deny
      end
    when 'no_contact'
      if positive
        api_user.sent_friendship_requests.create!(:user_id => user.id)
      end
    end
    render_no_content
  end

end
