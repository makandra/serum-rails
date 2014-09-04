# Changes an ActiveRecord class so its instances cannot be destroyed.
# origin: RM
module IndestructibleTrait
  as_trait do |*options|

    options = options[0] || {}

    before_destroy(options) do
      false
    end

    # Allow others to check whether this is an indestructible record.
    # This is not an ActiveRecord method.
    def destructible?
      false
    end

  end
end
