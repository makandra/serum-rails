# Utility methods to create hashes from collections. 
# origin: RM
module Enumerable

  def collect_hash(&pairer)
    collect_into_hash({}, &pairer)
  end

  def collect_ordered_hash(&pairer)
    collect_into_hash(ActiveSupport::OrderedHash.new, &pairer)
  end

  private

  def collect_into_hash(hash, &pairer)
    inject(hash) do |hash, key|
      pair = pairer.call(key)
      hash[pair[0]] = pair[1] unless pair.nil?
      hash
    end
  end

end
