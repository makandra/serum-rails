# Configures I18n in controllers.
# origin: RM
module ApplicationController::I18nTrait

  as_trait do
     
    prepend_before_filter :set_locale
    helper_method :translate_model_name
    
    private
    
    def translate_model_name(model)
      klass = model
      klass = klass.class if klass.is_a?(ActiveRecord::Base)
      klass.human_name
    end

    def set_locale
      I18n.locale = 'en'
    end
    
  end

end
