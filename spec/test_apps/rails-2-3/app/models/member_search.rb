# Maps the member search form to the scopes provided by the user model.
# origin: M
class MemberSearch

  attr_reader :users, :name

  def initialize(user, options = nil)
    options ||= {} # When using params from the controller without any search query, nil will be passed. Thus, assigning a default value here.
    @users = User.active
    @users = @users.search(options[:name], user) if options[:name].present?
  end

  # Define this method to silence deprecation warnings when we are using the non-ActiveRecord class in Rails forms.
  def id
    nil
  end

end
