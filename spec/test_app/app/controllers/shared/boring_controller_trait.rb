# Provides a resource_controller preconfigured with options you want 99% of the time. Used by most controllers that do CRUD.
# origin: RM
module BoringControllerTrait
  as_trait do |*options|
    
    options = options.first || {}

    options[:singleton] ? resource_controller(:singleton) : resource_controller

    does 'boring_controller_trait/flash'
    does 'boring_controller_trait/deletable' unless options[:destroy_is_permanent]
    does 'boring_controller_trait/index', options unless options[:singleton]
    does 'boring_controller_trait/helpers', options

  end
end
