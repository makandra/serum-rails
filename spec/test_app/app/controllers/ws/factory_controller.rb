# Controller for /ws/reset and /ws/factorydefaults
# origin: M
class Ws::FactoryController < Ws::ApiController

  def reset
    api_user.may_reset_application_state!

    clean_and_create_admin!

    render_no_content
  end

  def factorydefaults
    api_user.may_reset_application_state!

    clean_and_create_admin!

    users, categories, series, conferences = JSON.parse(File.read("#{Rails.root}/assets/data.json"))

    users.each do |user|
      User.create(parse_user(user))
    end

    categories.each do |category|
      Category.create(parse_category(category))
    end

    conferences.each do |conference|
      Conference.create(parse_conference(conference))
    end

    render_no_content
  end

  private

  def clean_and_create_admin!
    [Attendance, Category, ConferenceCategory, Conference, FriendshipRequest, Friendship, Invitation, User].each do |model|
      model.delete_all
    end

    User.create_admin!
  end

end
