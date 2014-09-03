# Trait to provide an inactive state to any ActiveRecord model, e.g. a class supporting soft-deletion or archival.
# origin: RM
module AfterlifeTrait

  as_trait do |*options|
    options = options.first || {}
    adjective = options.delete(:as) || 'deleted'
    
    with_adjective ="with_#{adjective}"

    does "flag", adjective, :default => false
    named_scope :active, :conditions => { adjective => false }
    named_scope with_adjective, lambda { |show_perished|
      { :conditions => (show_perished ? nil : { adjective => false }) }
    }
  end

end
