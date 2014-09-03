# Provides a virtual attribute that can be get and set like an array, but is realized into other data structure upon saving.
# origin: RM
module ListFieldTrait

  # This is an array that stringifies with comma separators, so we can
  # have a text field in the form for it.
  class CommaSeparatedArray

    include Enumerable

    def initialize(list)
      @list = list
    end

    def each(&block)
      @list.each(&block)
    end

    def <<(element)
      @list << element
    end

    def to_s
      @list.join(', ')
    end

    def to_a
      @list
    end

    def self.wrap(list)
      list.is_a?(self) ? list : new(list)
    end
    
  end

  as_trait do |*args|

    list = args[0]
    options = args[1] || {}
    
    cast_to_integer = options[:integer]
    list_variable = "@#{list}"
    set_list = "#{list}="
    read_list = "read_#{list}"
    write_list = "write_#{list}"
    write_list_if_changed = "write_#{list}_if_changed"

    after_save write_list_if_changed

    define_method list do
      CommaSeparatedArray.wrap(instance_variable_get(list_variable) || send(read_list))
    end

    define_method write_list_if_changed do
      list = instance_variable_get(list_variable)
      send(write_list, list) if list
      true
    end

    define_method set_list do |new_list|
      new_list = new_list.split(/\s*,\s*/) if new_list.is_a?(String)
      new_list.reject!(&:blank?)
      new_list.collect!(&:to_i) if cast_to_integer
      instance_variable_set(list_variable, new_list)
    end

  end

end