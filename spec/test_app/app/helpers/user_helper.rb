# Helper methods that deal with the display of user information.
# origin: M
module UserHelper

  def friendship_status(user, only_image = false)
    icon, title = if current_user == user
      [ 'icons/user-red.png', 'This is you' ]
    elsif current_user.friends_with?(user)
      [ 'icons/user-medium.png', 'Confirmed contact' ]
    elsif current_user.in_contact_with?(user)
      [ 'icons/mail.png', 'Contact request sent' ]
    else
      [ 'icons/user-gray_gray.png', 'No confirmed contact' ]
    end

    if only_image
      image_tag icon, :title => title, :alt => title
    else
      content_tag :div, title, :class => 'friend_status', :style => "background-image: url(#{image_path icon})"
    end
  end

end
