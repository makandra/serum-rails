# A single conference category.
# origin: M
class Category < ActiveRecord::Base

  does 'category/ancestry'
  does 'sortable', :by => :name
  does 'indestructible'

  validates_presence_of :name
  validates_uniqueness_of :name

  named_scope :by_name, :order => :name

  def conferences
    category_ids = (descendants.collect(&:id) + [id]).uniq
    Conference.in_categories(category_ids)
  end

  def available_parents
    (Category.all - [self]).sort.collect do |category|
      [category.name, category.id]
    end
  end

end
