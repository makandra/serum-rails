# Provides macros to quickly configure a resource_controller.
# origin: RM
module BoringControllerTrait::HelpersTrait
  as_trait do |options|
  
    if options[:show_is_edit]
      for action in [:show, :update, :create] do
        send(action).wants.html do
          redirect_to edit_object_path
        end
      end
    end

    if options[:for_forms]
      before_filter :only => [:new, :create, :edit, :update] do |c|
        c.send(options[:for_forms])
      end
    end

    private

    if options[:model_name]

      define_method :model_name do
        options[:model_name]
      end

      define_method :object_name do
        options[:model_name]
      end

    end

  end
end
