class CategoriesController< ApplicationController
  include ::Traits::Controller::Resource
  before_filter :find_resources, :only => [:index]
  before_filter :find_resource!, :only => [:show]

  def index
    redirect_to category_path(Category.root)
  end

  def show
  end

protected
  def resource_key
    :slug
  end
end
