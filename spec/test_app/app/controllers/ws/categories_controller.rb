# Controller for /ws/categories
# origin: M
class Ws::CategoriesController < Ws::ApiController

  public_actions :index, :show

  def index
    root_categories = Category.roots
    if root_categories.any?
      render :json => format_categories(root_categories)
    else
      render_no_content
    end
  end

  def create
    api_user.may_create_category!

    category = Category.new(parse_category(json_params))

    category.save!
    render :json => format_category(category)
  end

  def show
    category = Category.find(params[:id])
    render :json => format_category(category)
  end

end
