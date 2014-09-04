# Provides a search scope with Google-esque syntax for ActiveRecord models, e.g. "foo bar date:20090511 baz"
# origin: RM
module SearchableTrait

  TEXT_QUERY = /(?:"([^"]+)"|([\w\-@\._]+))/
  FIELD_QUERY = /(\w+)\:#{TEXT_QUERY}/

  as_trait do |options|

    text_field = options[:text_means] || :text # the field we're searching when no field is given

    class << self
      attr_accessor :defined_searchers
    end

    singleton_class.send :define_method, :search do |query|
      query = query.dup # we are going to delete substrings in-place
      scope = scoped({})
      scope = filter_by_field_queries(scope, query)
      scope = filter_by_text_queries(scope, query)
      scope
    end

    private

    singleton_class.send :define_method, :search_by do |*fields, &searcher|
      self.defined_searchers ||= {}
      fields.each do |field|
        defined_searchers[field.to_s.downcase] = true
        # we need to define the searcher as an actual method because of the way scopes delegate methods to the AR class
        singleton_class.send :define_method, "search_by_#{field}", &searcher
      end
    end

    singleton_class.send :define_method, :filter_by_field_queries do |scope, query|
      while query.sub!(SearchableTrait::FIELD_QUERY, '')
        field = $1
        value = "#{$2}#{$3}"
        scope = search_by_field(scope, field, value)
      end
      scope
    end

    singleton_class.send :define_method, :filter_by_text_queries do |scope, query|
      while query.sub!(SearchableTrait::TEXT_QUERY, '')
        value = "#{$1}#{$2}"
        scope = search_by_field(scope, text_field, value)
      end
      scope
    end

    singleton_class.send :define_method, :search_by_field do |scope, field, value|
      normalized_field = field.to_s.downcase
      if defined_searchers[normalized_field]
        scope = scope.send("search_by_#{normalized_field}", value)
      else
        scope = scope.find_nothing
      end
      scope
    end

    singleton_class.send :define_method, :find_nothing do
      scoped(:conditions => "1=2")
    end

    search_by text_field do |text|
      scoped(:conditions => Util.like_query(text_field, text))
    end

  end
end
