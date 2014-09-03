# Describes the navigation used by the application views.
# Controllers can map their actions into symbols defined by this class.
# origin: RM
class Navigation < SimpleNavigation

  navigation :main do
    section :conferences, :label => 'Conferences', :url => lambda { conferences_path } do
      section :browse, :label => 'Browse', :url => lambda { conferences_path }
      section :search, :label => 'Search', :url => lambda { search_conferences_path }
      section :invitations, :label => 'Invitations', :url => lambda { invitations_path }, :show => lambda { current_user.may_index_invitations? }
    end
    section :members, :label => 'Members', :url => lambda { members_path }, :show => lambda { current_user.may_index_members? } do
      section :member_search, :label => 'Search', :url => lambda { members_path }
      section :profile, :label => 'My profile', :url => lambda { user_path(current_user) }, :show => lambda { current_user.may_access_own_profile? }
    end
    section :admin_users, :label => 'Admin users', :url => lambda { admin_users_path }, :show => lambda { current_user.may_index_admin_users? } do
      section :active_users, :label => 'Active users', :url => lambda { admin_users_path }
      section :deleted_users, :label => 'Deleted users', :url => lambda { deleted_admin_users_path }
    end
    section :admin_categories, :label => 'Admin categories', :url => lambda { admin_categories_path }, :show => lambda { current_user.may_index_admin_categories? }
  end

  navigation :admin_category do
    section :show, :label => lambda { icon(:show, 'Overview') }, :url => lambda { object_path }
    section :edit, :label => lambda { icon(:edit, 'Edit') }, :url => lambda { edit_object_path }
  end

  navigation :conference do
    section :show, :label => lambda { icon(:show, 'Overview') }, :url => lambda { object_path }
    section :edit, :label => lambda { icon(:edit, 'Edit') }, :url => lambda { edit_object_path }, :show => lambda { current_user.may_update_conference?(object) }
  end

  navigation :user do
    section :show, :label => lambda { icon(:show, 'Overview') }, :url => lambda { object_path }
    section :edit, :label => lambda { icon(:edit, 'Edit') }, :url => lambda { edit_object_path }, :show => lambda { current_user.may_update_user?(object) }
  end

end
