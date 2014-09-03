# Controller for /ws/conference/{id}/attendees
# origin: M
class Ws::AttendeesController < Ws::ApiController

  public_actions :index

  def index
    conference = Conference.find(params[:conference_id])
    attendees = conference.attendees
    if attendees.any?
      render :json => format_users(conference.attendees)
    else
      render_no_content
    end
  end

  def create
    conference = Conference.find(params[:conference_id])
    api_user.may_attend_conference!(conference)
    username = json_params['username']
    if username != api_user.username
      raise Aegis::AccessDenied
    end

    conference.attend!(api_user)

    render_no_content
  end

  def destroy
    conference = Conference.find(params[:conference_id])
    api_user.may_cancel_attendance_conference!(conference)
    username = params[:id]
    if username != api_user.username
      raise Aegis::AccessDenied
    end

    conference.cancel_attendance!(api_user)

    render_no_content
  end

end
