# Allows to reload already loaded records.
# origin: RM
ActiveRecord::Base.class_eval do
  class << self
    public :preload_associations
  end
end
