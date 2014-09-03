# Trait to parse incoming json objects
# origin: M
module Ws::ApiController::ParsersTrait
  as_trait do

    def find_user(user)
      if user
        User.find_by_username(user['username'])
      end
    end

    def find_categories(categories)
      if categories
        Category.find_all_by_name(categories.collect { |category| category['name'] }).collect(&:id)
      else
        []
      end
    end

    def find_category(name)
      Category.find_by_name(name) if name
    end

    def compact_hash!(hash)
      hash.delete_if { |key, value| value.nil? }
    end

    def parse_conference(conference)
      compact_hash!(
        :name => conference['name'],
        :user => find_user(conference['creator']),
        :start_date => conference['startdate'],
        :end_date => conference['enddate'],
        :category_list => find_categories(conference['categories']),
        :description => conference['description'],
        :address => conference['location']
      )
    end

    def parse_category(category)
      {
        :name => category['name'],
        :parent => find_category(category['parent'].andand['name'])
      }
    end

    def parse_user(user)
      compact_hash!(
        :username => user['username'],
        :password => user['password'],
        :password_confirmation => user['password'],
        :full_name => user['fullname'],
        :email => user['email'],
        :town => user['town'],
        :country => user['country']
      )
    end
  end
end
