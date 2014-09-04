# Models a conference.
# origin: M
class Conference < ActiveRecord::Base
  does 'conference/categories'
  does 'conference/attendance'
  does 'conference/icalendar'
  does 'conference/search'

  belongs_to :user

  validates_presence_of :name, :start_date, :end_date, :description, :address, :user_id

  named_scope :by_name, :order => :name
  named_scope :running, lambda {{ :conditions => ['start_date <= ? AND ? <= end_date', Date.today, Date.today] }}

  has_attachment :logo

  validate do |record|
    if record.start_date and record.end_date and record.start_date > record.end_date
      record.errors.add :end_date, 'must be after the start date'
    end
  end

end
