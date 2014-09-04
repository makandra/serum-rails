# Provides category hierarchies.
# origin: RM
module Category::AncestryTrait
  as_trait do

    has_ancestry

    belongs_to :mother, :class_name => 'Category'
    before_validation :sync_mother_and_parent_id

    # This method serves two purposes:
    # 1. Cache ancestry's virtual parent_id in a real database column because that makes some queries easier
    # 2. Allow to set parent_id by setting mother_id so code that uses association reflection works
    def sync_mother_and_parent_id
      if mother_id_changed?
        self.parent_id = mother_id
      else
        self.mother_id = parent_id
      end
    end

  end
end
