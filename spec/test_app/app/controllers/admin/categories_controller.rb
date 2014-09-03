# Controller to manage category as an admin.
# origin: M
class Admin::CategoriesController < ApplicationController

  does 'boring_controller',
    :order => 'categories.name'

  in_sections :admin_categories
  permissions :admin_categories

  private

  def collection_scope
    Category.roots.by_name
  end

end
