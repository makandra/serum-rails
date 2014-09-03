# Trait to provide search functionality for conferences.
# origin: M
module Conference::SearchTrait

  as_trait do

    does 'searchable', :text_means => 'query'

    named_scope :in_categories, lambda { |ids| { :conditions => ['conference_categories.category_id IN (?)', ids], :joins => :conference_categories, :group => 'conferences.id' } }

    named_scope :from_date, lambda { |date| { :conditions => ['conferences.end_date >= ?', date] } }
    named_scope :until_date, lambda { |date| { :conditions => ['conferences.start_date <= ?', date] } }

    search_by :query do |query|
      scoped :conditions => Util.like_query('CONCAT_WS(" ", conferences.name, conferences.description)', query)
    end

    search_by :from do |date_string|
      date = Date.parse(date_string) rescue nil
      if date
        from_date(date)
      else
        self
      end
    end

    search_by :until do |date_string|
      date = Date.parse(date_string) rescue nil
      if date
        until_date(date)
      else
        self
      end
    end

    search_by :cat do |category_string|
      category_id = Category.find_by_name(category_string).andand.id
      in_categories([category_id])
    end


  end

end
