# Models the pattern of a boolean attribute that must be true or false, but never nil.
# origin: RM
module FlagTrait

  as_trait do |field, options|

    options ||= {}

    default = options[:default]
    virtual = options[:virtual]
    field_var = "@#{field}"
    set_field = "#{field}="

    validates_inclusion_of field.to_sym, :in => [true, false], :allow_nil => !!virtual 
    has_defaults field.to_sym => default

    if virtual

      attr_reader field

      define_method set_field do |value|
        value = ActiveRecord::ConnectionAdapters::Column.value_to_boolean(value)
        instance_variable_set(field_var, value)
      end

    end

  end 

end
