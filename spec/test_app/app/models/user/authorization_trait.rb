# Hooks up the aegis gem so users can be given roles and be queried for permissions.
# origin: RM
module User::AuthorizationTrait
  as_trait do

    has_role :default => 'user'
    validates_role

    def self.available_roles
      labeler = lambda { |role| I18n.t("roles.#{role.name}") }
      Permissions.roles.sort_by(&labeler).collect_ordered_hash do |role|
        [role.name, labeler.call(role)]
      end
    end    

  end
end
