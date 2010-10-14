# encoding: utf-8
class ArticlesController < ApplicationController
  include ::Traits::Controller::Resource
  include ::Traits::Controller::Action::Create
  include ::Traits::Controller::Action::Update
  include ::Traits::Controller::Action::Destroy
  before_filter :build_resource, :only => [:new, :create]
  before_filter :assign_author,  :only => [:new, :create]
  before_filter :find_resource!, :only => [:show, :edit, :update, :destroy, :approve, :unapprove]
  before_filter :check_creatability,  :only => [:new, :create]
  before_filter :check_approvability, :only => [:approve, :unapprove]
  before_filter :check_editability,   :only => [:edit, :update]
  before_filter :check_deletability,  :only => [:delete]

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

  def check_creatability
    Article.creatable_by?(current_person) || bad_request!
  end
  
  def check_approvability
    @article.approvable_by?(current_person) || bad_request!
  end

  def check_editability
    @article.editable_by?(current_person) || bad_request!
  end
  
  def check_deletability
    @article.deletable_by?(current_person) || bad_request!
  end
  
  def respond_on_successful_update
    redirect_to @article, :notice => "Статья была успешно изменена"
  end
  
  def respond_on_successful_create
    if @article.viewable_by?(current_person)
      redirect_to @article, :notice => "Статья была успешно создана"
    else
      redirect_to category_path(Category.root), :notice => "Статья была создана, дождитесь ее одобрения ньюсмейкерами"
    end
  end
end
