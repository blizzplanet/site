class CommentsController < ApplicationController
  include ::Traits::Controller::Resource
  include ::Traits::Controller::Action::Create
  include ::Traits::Controller::Action::Update
  include ::Traits::Controller::Action::Destroy

  before_filter :find_article!
  before_filter :build_resource, :only => [:create]
  before_filter :assign_author,  :only => [:create]
  before_filter :assign_article, :only => [:create]
  before_filter :find_resource!, :only => [:update, :destroy]

protected
  def assign_author
    @comment.author = current_person
  end

  def find_article!
    @article = Article.first(:id => params[:article_id].to_i)
    @article || not_found!
  end

  def assign_article
    @comment.article = @article
  end

  def resource_scope
    @article.comments
  end

  def respond_on_unsuccessful_create
    render "articles/show", :status => :bad_request
  end

  def successful_create_url
    article_url(@article)
  end
end
