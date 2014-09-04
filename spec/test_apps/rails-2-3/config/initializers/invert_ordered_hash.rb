# Method to switch keys and values of an ordered hash.
# origin: RM
ActiveSupport::OrderedHash.class_eval do

  def invert
    inject(ActiveSupport::OrderedHash.new) do |res, pair|
      res[pair[1]] = pair[0]
      res
    end
  end

end
