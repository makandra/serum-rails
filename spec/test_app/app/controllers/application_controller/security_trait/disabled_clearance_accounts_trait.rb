module Clearance
  class DisabledAccount < StandardError
  end
end

# Trait to ensure disabled (locked, deleted) users cannot sign in.
# origin: RM
module ApplicationController::SecurityTrait::DisabledClearanceAccountsTrait
  as_trait do

    private

    def user_from_cookie_with_disabled_accounts
      user = user_from_cookie_without_disabled_accounts
      if user && user.account_disabled?
        cookies.delete(:remember_token)
        raise Clearance::DisabledAccount, "Signed out user ##{user.id} because her account has been disabled"
      end
      user
    end

    alias_method_chain :user_from_cookie, :disabled_accounts

    def sign_in_with_disabled_accounts(user)
      if user.account_disabled?
        raise Clearance::DisabledAccount, "Cannot sign in user ##{user.id} because her account has been disabled"
      else
        sign_in_without_disabled_accounts(user)
      end
    end

    alias_method_chain :sign_in, :disabled_accounts

    rescue_from Clearance::DisabledAccount, :with => :deny_access_to_disabled_account

    def deny_access_to_disabled_account
      deny_access translate('disabled_account', :default =>  "Your account has been disabled")
    end

  end
end