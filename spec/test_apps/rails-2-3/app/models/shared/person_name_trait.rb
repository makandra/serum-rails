# Provides an attribute #full_name that is composed from #first_name and #last_name.
# origin: RM
module PersonNameTrait
  as_trait do

    # validates_presence_of :last_name

    before_validation :store_full_name

    def full_name
      [first_name, last_name].select(&:present?).join(" ")
    end

    def name
      full_name
    end
    
    private

    def store_full_name
      self.full_name = full_name
    end

  end
end
