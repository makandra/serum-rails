# Helper methods for mailer views.
# origin: RM
module MailHelper

  def reset_password_link(user)
    edit_password_url(:user_id => user, :token  => user.confirmation_token, :escape => false)
  end

end
