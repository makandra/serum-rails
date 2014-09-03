# Configures a resource_controller to automatically set a user performing a record change.
# origin: RM
module BoringControllerTrait::LogChangesTrait
  as_trait do

    [:object, :build_object].each do |method|
      define_method method do |*args|
        super.tap do |record|
          if record.present? && record.respond_to?(:changing_user=)
            record.changing_user = current_user
            # the actual logging takes place in the object model after saving
          end
        end
      end
    end

  end
end
