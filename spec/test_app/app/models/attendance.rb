# Stores the fact that a user is attending a conference.
# origin: M
class Attendance < ActiveRecord::Base

  validates_presence_of :user_id, :conference_id
  validates_uniqueness_of :user_id, :scope => :conference_id

  belongs_to :user
  belongs_to :conference

end