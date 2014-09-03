# Trait to manage the attendees of a conference.
# origin: M
module Conference::AttendanceTrait
  as_trait do

    has_many :attendances, :dependent => :destroy
    has_many :attendees, :through => :attendances, :source => :user

    def attended_by?(user)
      @attendee_ids ||= attendee_ids
      @attendee_ids.include?(user.id)
    end

    def attend!(user)
      attendees << user unless attended_by?(user)
    end

    def cancel_attendance!(user)
      attendees.delete(user) if attended_by?(user)
    end
    
  end
end