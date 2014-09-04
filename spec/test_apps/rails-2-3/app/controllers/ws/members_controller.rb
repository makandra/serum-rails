# Controller for /ws/members
# origin: M
class Ws::MembersController < Ws::ApiController

  public_actions :create

  def create
    user = User.new(parse_user(json_params))

    user.save!
    render :json => format_user(user, :full_details => true)
  end

  def show
    user = User.find_by_username!(params[:id])

    render :json => format_user(user, :full_details => api_user.sees_details_of?(user))
  end

  def update
    user = User.find_by_username!(params[:user_id])
    unless user == api_user
      raise Aegis::AccessDenied
    end

    user.attributes = parse_user(json_params)

    validate_version!(user, json_params['version'])

    user.save!
    render :json => format_user(user, :full_details => true)
  end

end
