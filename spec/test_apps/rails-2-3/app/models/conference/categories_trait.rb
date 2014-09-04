# Trait to manage the categories of a conference.
# origin: M
module Conference::CategoriesTrait

  as_trait do
    
    has_many :conference_categories
    has_many :categories, :through => :conference_categories

    does 'list_field', :category_list

    def category_names
      categories.collect(&:name)
    end

    def read_category_list
      category_ids.collect(&:to_s)
    end

    def write_category_list(ids)
      self.category_ids = ids.collect(&:to_i)
    end

  end

end
