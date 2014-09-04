# Describes what a user is allowed to do in the application.
# origin: M
class Permissions < Aegis::Permissions

  role :admin
  role :user
  role :guest

  missing_user_means { User.guest }
  missing_action_means :error

  namespace :admin do
    resources :users do
      action :deleted, :collection => true
      allow :admin
    end
    resources :categories do
      allow :admin
    end
  end

  resource :categories do
    writing do
      allow :admin
    end
    reading do
      allow :everyone
    end
  end

  resources :conferences do
    action :index, :search, :collection => true do
      allow :everyone
    end
    action :show do
      allow :everyone
    end
    action :update, :destroy do
      allow :user, :admin do 
        object.user == user
      end
    end
    action :create do
      allow :user, :admin
    end
    action :attend, :cancel_attendance do
      allow :user, :admin
    end
  end

  resources :invitations do
    action :create, :index do
      allow :user, :admin
    end
    action :accept, :dismiss do
      allow :user, :admin do
        object.recipient == user
      end
    end
  end

  resources :users do
    action :create do
      allow :everyone
    end
    action :show do
      allow :everyone
    end
    action :update do
      allow :admin, :user do
        user == object
      end
    end
    action :request_friendship do
      allow :user, :admin
    end
    action :search_all_fields, :collection => true do
      allow :admin
    end
  end

  resources :members do
    action :request_friendships, :collection => true
    allow :user, :admin
  end

  resources :friends do
    allow :user, :admin
    action :accept, :deny do
      allow :user, :admin do
        object.user == user
      end
    end
  end

  resource :own_profile do
    action :access do
      allow :user, :admin
    end
  end

  action :reset_application_state do
    allow :admin
  end

end
