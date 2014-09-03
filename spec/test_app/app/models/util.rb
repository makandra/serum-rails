# Utility methods.
# origin: RM
module Util

  extend self

  def collect_ids(records_or_ids)
    Array(records_or_ids).collect { |o| o.is_a?(ActiveRecord::Base) ? o.id : o }
  end

  def like_query(field, query)
    ["#{field} LIKE ?", "%#{escape_for_like_query(query)}%"]
  end

  def escape_for_like_query(word)
    word.gsub("%", "\\%").gsub("_", "\\_")
  end

end
