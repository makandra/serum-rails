# Models the pattern of a string attribute that has a fixed number of allowed choices with additional human labels.
# origin: RM
module ChoiceTrait

  as_trait do |field, options|

    options[:choices] = options[:choices].zip(options[:choices]).flatten if options[:no_hash]
    choices = ActiveSupport::OrderedHash[*options[:choices]]

    available_values = "available_#{field.to_s.pluralize}"

    metaclass ||= singleton_class
    metaclass.send(:define_method, available_values) do
      choices
    end

    validates_inclusion_of field.to_sym, :in => send(available_values).keys, :allow_blank => !!options[:allow_blank]

    if options.has_key?(:default)
      has_defaults field.to_sym => options[:default]
    end

    define_method "humanized_#{field}" do
      choices[send(field)]
    end

    if options[:query_methods]
      choices.keys.each do |key|
        define_method "#{key}?" do
          send(field) == key
        end
      end
    end

  end

end
