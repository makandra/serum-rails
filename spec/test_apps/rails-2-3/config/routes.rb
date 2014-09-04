# Maps URLs to controller actions.
# Origin: RM
ActionController::Routing::Routes.draw do |map|

  map.root :controller => :conferences, :action => :index

  map.resources :invitations, :only => [:index, :new, :create], :member => { :accept => :put, :dismiss => :delete }

  map.resources :conferences, :collection => { :search => :get }, :member => { :attend => :put, :cancel_attendance => :put }
  
  map.resource :session, :only => [:new, :create, :destroy]

  map.resource :password

  map.resources :users, :except => [:delete, :index], :member => { :request_friendship => :put }

  map.resources :friendship_requests, :only => [], :member => { :accept => :put, :deny => :delete }

  map.resources :members, :only => [ :index ], :collection => { :request_friendships => :post }

  map.namespace :admin do |admin|
    admin.resources :users, :collection => {:deleted => :get}
    admin.resources :categories, :except => :destroy
  end

  map.namespace :ws do |ws|
    ws.resources :conferences, :except => :update do |ws_conferences|
      ws_conferences.resources :attendees
    end
    ws.update_conference 'conferences/:conference_id', :controller => 'conferences', :action => 'update', :conditions => { :method => :put }
    ws.resources :members, :except => :update do |ws_members|
      ws_members.resources :contacts
    end
    ws.update_user 'users/:user_id', :controller => 'members', :action => 'update', :conditions => { :method => :put }
    ws.conferences_by_category 'conferencesbycategory/:category_id', :controller => 'conferences', :action => 'by_category', :conditions => { :method => :get }
    ws.conference_search 'search/:query', :controller => 'conferences', :action => 'search', :conditions => { :method => :get }
    ws.resources :categories
    ws.resources :series, :only => %w[ index create show ]
    ws.connect 'reset', :controller => 'factory', :action => 'reset'
    ws.connect 'factorydefaults', :controller => 'factory', :action => 'factorydefaults'
    if Rails.env.test?
      map.connect 'ws/test/:action', :controller => 'ws/tests'
    end
    
  end

end
