# Provides soft-deletion for ActiveRecord models.
# origin: RM
module DeletableTrait
  as_trait do
    does 'afterlife', :as => 'deleted'
    does "indestructible"
  end
end
