class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def edit
  end

  def show
  end

  def delete
  end

  def new
    @post = Post.new
  end
end
