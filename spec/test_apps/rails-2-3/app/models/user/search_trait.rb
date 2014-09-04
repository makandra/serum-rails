# Provides search for user records.
# origin: M
module User::SearchTrait
  as_trait do

    TEXT_QUERY = /(?:"([^"]+)"|([\w\-@\._]+))/

    # Returns users matching the given query.
    # Users may search additional fields of a user they are friends with.
    # Admins may search all fields.
    def self.search(query, searching_user)
      friend_ids = searching_user.friend_ids
      like_username = find_words_in_field('users.username', query)
      like_full_name = find_words_in_field('users.full_name', query)
      like_email = find_words_in_field('users.email', query)
      conditions = if searching_user.may_search_all_fields_users?
        "(#{like_username}) OR (#{like_full_name}) OR (#{like_email})"
      elsif friend_ids.any?
        is_friend = "users.id IN (#{friend_ids.join ', '})"
        "(#{is_friend}) AND (#{like_full_name}) OR (#{like_username})"
      else
        like_username        
      end
      scoped :conditions => conditions
    end

    private

    def self.find_words_in_field(field, query)
      collect_words(query) do |word|
        sanitize_sql_for_conditions(Util.like_query(field, word))
      end.join(' AND ')
    end

    def self.collect_words(query, &block)
      query.scan(TEXT_QUERY).collect do |phrase_match, word_match|
        word = "#{phrase_match}#{word_match}"
        block.call(word)
      end
    end

  end
end
