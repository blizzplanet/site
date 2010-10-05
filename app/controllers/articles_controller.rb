class ArticlesController < ApplicationController
  include ::Traits::Controller::Resource
  before_filter :build_resource, :only => [:new, :create]

  def new
  end

  def create
  end

  def index    
  end

protected

end
