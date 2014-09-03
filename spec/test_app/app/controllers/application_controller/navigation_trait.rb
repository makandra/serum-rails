# Allows controllers to associate actions with tabs in the site navigation.
# origin: RM
module ApplicationController::NavigationTrait
  as_trait do

    before_filter :set_default_section

    DEFAULT_SECTIONS = { 'edit' => 'edit', 'update' => 'edit', 'show' => 'show', 'index' => 'index' }

    private

    def set_default_section
      DEFAULT_SECTIONS[action_name].andand.tap do |section|
        in_sections section
      end
    end

  end
end
