# Utility class to provide common regular expressions.
# origin: RM
class Patterns
  
  EMAIL = /\A[a-z0-9\+\-_\.]+@[a-z0-9]+[a-z0-9\-\.]*[a-z0-9]+\z/i
  HOST = /\A[a-z0-9]+[a-z0-9\-\.]*[a-z0-9]+\z/i
  URL = /(http|https):\/\/[\w\-_]+(\.[\w\-_]+)*([\w\-\.,@?^=%&amp;:\/~\+#]*[\w\-\@?^=%&amp;\/~\+#])?/

  # Returns a regexp without start-of-string and end-of-string assertions
  def self.partial(pattern)
    Regexp.compile(pattern.source.sub(/^(\\A|\^)/, '').sub(/(\\z|\$)$/, ''))
  end
  
end
