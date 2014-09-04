# Controller for /ws/conferences
# origin: M
class Ws::ConferencesController < Ws::ApiController

  public_actions :show, :by_category, :search

  def show
    conference = Conference.find(params[:id])
    render :json => format_conference(conference)
  end

  def create
    api_user.may_create_conference!

    conference = Conference.new(parse_conference(json_params))
    set_conference_fields(conference)

    conference.save!
    render :json => format_conference(conference)
  end

  def update
    conference = Conference.find(params[:conference_id])
    api_user.may_update_conference!(conference)

    conference.attributes = parse_conference(json_params)
    set_conference_fields(conference)

    validate_version!(conference, json_params['version'])

    conference.save!
    render :json => format_conference(conference)
  end

  def by_category
    category = Category.find params[:category_id]
    if category.conferences.any?
      render :json => format_conferences(category.conferences)
    else
      render_no_content
    end
  end

  def search
    conferences = ConferenceSearch.new(params.slice(:query) || {}).find
    if conferences.any?
      render :json => format_conferences(conferences)
    else
      render_no_content
    end
  end

  private

  def set_conference_fields(conference)
    conference.user ||= api_user
    if conference.user != api_user
      raise Aegis::AccessDenied
    end
  end

end
