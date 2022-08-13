# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @posts = Post.all
    @posts = policy_scope(Post).reverse
  end

  def edit; end

  def show; end

  def destroy
    if @post.destroy
      redirect_to posts_url, notice: 'Post was successfully deleted.'
    else
      redirect_to posts_url, notice: "Something went wrong.#{@post.errors}"
    end
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    authorize @post
    if @post.save
      redirect_to post_url(@post), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity,
                   notice: "Post was not created due to some issue. Please try again. #{@post.errors} "
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post), notice: 'post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity,
                    notice: "Post was not successfully updated. Please try again. #{@post.errors} "
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def post_params
    params.require(:post).permit(:caption, :user_id, images: [])
  end
end
