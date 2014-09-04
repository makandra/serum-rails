require 'vpim/icalendar'

# Trait to export a conference in iCalendar format.
# origin: M
module Conference::IcalendarTrait
  as_trait do

    def to_icalendar(viewing_user)
      Vpim::Icalendar.create2.tap do |calendar|
        calendar.add_event do |e|
          e.dtstart start_date
          e.dtend(end_date + 1.day)
          e.summary name
          e.description description
          e.categories category_names
          e.organizer visible_vcard_address(user, :for => viewing_user)
          for attendee in attendees
            e.add_attendee visible_vcard_address(attendee, :for => viewing_user)
          end
        end
      end
    end

    private

    def visible_vcard_address(user, options)
      viewing_user = options[:for]
      force_visible = (user == self.user) 
      Vpim::Icalendar::Address.new.tap do |address|
        address.cn = viewing_user.name_for(user, force_visible)
        address.uri = viewing_user.sees_details_of?(user, force_visible) ? "mailto:#{user.email}" : NO_REPLY_EMAIL
      end
    end

  end
end
