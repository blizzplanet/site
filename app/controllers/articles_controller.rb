class ArticlesController < ApplicationController
  include ::Traits::Controller::Resource
  include ::Traits::Controller::Action::Create
  include ::Traits::Controller::Action::Update
  before_filter :build_resource, :only => [:new, :create]
  before_filter :find_resource!, :only => [:show, :edit, :update, :destroy]


  def index
    redirect_to category_url(Category.root)
  end

  def show
    @category = @article.category
  end

protected
  def new_resource_attributes
    super.merge(:author => current_person)
  end

end
