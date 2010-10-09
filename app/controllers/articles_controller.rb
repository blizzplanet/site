class ArticlesController < ApplicationController
  include ::Traits::Controller::Resource
  include ::Traits::Controller::Action::Create
  include ::Traits::Controller::Action::Update
  include ::Traits::Controller::Action::Destroy
  before_filter :build_resource, :only => [:new, :create]
  before_filter :assign_author,  :only => [:new, :create]
  before_filter :find_resource!, :only => [:show, :edit, :update, :destroy]


  def index
    redirect_to category_url(Category.root)
  end

  def show
    @category = @article.category
    @comments = @article.comments
  end

protected
#
#  def resource_key
#    :slug
#  end

  def assign_author
    @article.author = current_person
  end
end
