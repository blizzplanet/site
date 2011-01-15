class CategoriesController< ApplicationController
  include ::Traits::Controller::Resource
  before_filter :find_resource!, :only => [:show]

  def index
    @category = Category.root
    show
    render "show"
  end

  def show
    @articles = Article.viewable_by(current_person).all(:category => @category.self_and_descendants, :order => :id.desc)
  end

protected
  def resource_key
    :slug
  end
end
