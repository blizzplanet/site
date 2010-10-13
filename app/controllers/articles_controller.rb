class ArticlesController < ApplicationController
  include ::Traits::Controller::Resource
  include ::Traits::Controller::Action::Create
  include ::Traits::Controller::Action::Update
  include ::Traits::Controller::Action::Destroy
  before_filter :build_resource, :only => [:new, :create]
  before_filter :assign_author,  :only => [:new, :create]
  before_filter :find_resource!, :only => [:show, :edit, :update, :destroy, :approve, :unapprove]
  before_filter :check_approvability, :only => [:approve, :unapprove]

  def index
    redirect_to category_url(Category.root)
  end

  def show
    @category = @article.category
    @comments = @article.comments
    @comment  = Comment.new
  end
  
  def approve
    @article.approve!
    redirect_to @article
  end
  
  def unapprove
    @article.unapprove!
    redirect_to @article
  end

protected
  def resource_scope
    Article.viewable_by(current_person)
  end

  def parse_resource_key(key)
    key.to_i
  end  

  def assign_author
    @article.author = current_person
  end
  
  def check_approvability
    @article.approvable_by?(current_person) || bad_request!
  end
end
