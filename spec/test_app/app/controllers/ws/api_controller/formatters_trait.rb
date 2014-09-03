# Trait to format CaP objects as json.
# origin: M
module Ws::ApiController::FormattersTrait
  as_trait do

    def format_date(date)
      date.strftime('%Y%m%d')
    end

    def format_version(time)
      time.to_i.to_s
    end

    def format_conference(conference, options = {})
      result = {
        'version' => format_version(conference.updated_at),
        'id' => conference.id,
        'name' => conference.name,
        'creator' => format_user(conference.user, :stub => true),
        'startdate' => format_date(conference.start_date),
        'enddate' => format_date(conference.end_date),
        'categories' => format_categories(conference.categories),
        'description' => conference.description,
        'location' => conference.address
      }
      if options[:stub]
        result.slice!('name', 'startdate', 'enddate', 'categories')
        result.merge!('details' => ws_conference_url(conference))
      end
      result
    end

    def format_conferences(conferences)
      conferences.collect do |conference|
        format_conference conference, :stub => true
      end
    end

    def format_users(users)
      users.collect do |user|
        format_user(user, :stub => true)
      end
    end

    def format_user(user, options = {})
      result = {
        'version' => format_version(user.updated_at),
        'id' => user.id,
        'username' => user.username,
        'fullname' => user.full_name,
        'email' => user.email,
        'town' => user.town,
        'country' => user.country,
        'status' => (api_user ? api_user.status_towards(user) : 'no_contact')
      }
      if options[:stub]
        result.slice!('username')
        result.merge!('details' => ws_member_url(user.username))
      end
      unless options[:full_details]
        result.delete('email')
        result.delete('fullname')
      end
      result
    end

    def format_category(category, options = {})
      { 'name' => category.name }.tap do |result|
        if options[:stub]
          result.merge! 'details' => ws_category_url(category)
        else
          mother = category.parent
          children = category.children
          result.merge!({
            'version' => format_version(category.updated_at),
            'id' => category.id,
            'parent' => mother.present? ? format_category(mother, :stub => true) : {},
            'subcategories' => children.collect{ |child| format_category(child, :stub => true) }
          })
        end
      end
    end

    def format_categories(categories)
      categories.collect do |category|
        format_category category, :stub => true
      end
    end

  end
end
