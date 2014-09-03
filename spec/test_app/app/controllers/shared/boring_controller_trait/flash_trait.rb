# Provides good default flash messages for controller actions.
# origin: RM
module BoringControllerTrait::FlashTrait
  as_trait do

    create.success.flash lambda { "#{translate_model_name(object)} created" }
    create.failure.flash lambda { error_flash("Could not save") }

    update.success.flash lambda { "#{translate_model_name(object)} updated" }
    update.failure.flash lambda { error_flash("Could not save") }

    destroy.success.flash lambda { "#{translate_model_name(object)} deleted" }
    destroy.failure.flash lambda { error_flash("Could not delete") }

    private

    # This is a hack because resource_controller uses flash[:notice] for everything
    def error_flash(msg)
      "<span class='error'>#{ERB::Util.html_escape msg}</span>".html_safe
    end

  end
end
