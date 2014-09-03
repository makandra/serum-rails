# Manages conferences as a conference creator. Also allows to sign up as an attendee and cancel the attendance again.
# origin: M
class ConferencesController < ApplicationController

  public_controller :only => [:index, :show, :search]

  in_sections :conferences

  does 'boring_controller', :destroy_is_permanent => true, :order => :name

  before_filter :set_category, :only => :index

  permissions :conferences

  create.before do
    object.user = current_user
  end

  index.before do
    in_sections :browse
    @running_conferences = end_of_association_chain.running
    @conference_search = ConferenceSearch.new
    @categories = if @category
      @category.children
    else
      Category.roots
    end.by_name
  end

  def search
    in_sections :search
    @conference_search = ConferenceSearch.new(params[:conference_search] || {})
    @conferences = paginate(@conference_search.find.by_name)
  end

  show.wants.ics do
    send_data object.to_icalendar(current_user).encode, :type => 'text/calendar'
  end

  def attend
    object.attend!(current_user)
    flash[:success] = "You have signed up for #{object.name}"
    redirect_to object_path
  end

  def cancel_attendance
    object.cancel_attendance!(current_user)
    flash[:success] = "You are no longer signed up for #{object.name}"
    redirect_to object_path
  end

  private

  def set_category
    if params[:category_id]
      @category = Category.find(params[:category_id])
    end
  end

  def end_of_association_chain
    if @category
      @category.conferences
    else
      Conference
    end.by_name
  end
end
