# Maps the conference search form to scopes provided by the conference model.
# origin: M
class ConferenceSearch

  attr_accessor :query, :category_ids, :from, :until

  def initialize(options = {})
    @query = options[:query]
    @category_ids = options[:category_ids] || []
    @until = options[:until]
    @from = options[:from]
  end

  def find
    scope = Conference
    if query
      scope = scope.search(query)
    end
    if category_ids.present?
      scope = scope.in_categories(category_ids)
    end
    if from_date
      scope = scope.from_date(from_date)
    elsif !until_date and (query.blank? or (!query.include?('from:') and !query.include?('to:')))
      scope = scope.from_date(Date.today)
    end
    if until_date
      scope = scope.until_date(until_date)
    end
    scope
  end

  # Define this method to silence deprecation warnings when we are using the non-ActiveRecord class in Rails forms.
  def id
    nil
  end

  def until_date
    Date.parse(@until) rescue nil
  end

  def from_date
    Date.parse(@from) rescue nil
  end

  def present?
    query.present? or from_date.present? or until_date.present? or category_ids.present?
  end


end
