# Macro to implement a comparison method for Ruby classes.
# origin: RM
module SortableTrait

  as_trait do |options|

    send(:define_method, :"<=>") do |other|
      fields = Array(options[:by])
      cmp = 0
      for field in fields
        left = send(field)
        left = left.downcase if left.respond_to?(:downcase)
        right = other.send(field)
        right = right.downcase if right.respond_to?(:downcase)
        cmp = left <=> right
        break unless cmp == 0
      end
      cmp *= -1 if options[:descending]
      cmp
    end
      
  end
  
end