# Controller support for indestructible records that set deleted flags instead of destroying themselves.
# origin: RM
module BoringControllerTrait::DeletableTrait
  as_trait do
    
    def destroy
      load_object
      object.deleted = !object.deleted?
      if object.save
        if object.deleted?
          set_flash :destroy
        else
          flash[:notice] = "#{translate_model_name(object)} restored"
        end
        redirect_to collection_url
      else
        set_flash :destroy_fails
        redirect_to edit_object_path
      end
    end

  end
end
