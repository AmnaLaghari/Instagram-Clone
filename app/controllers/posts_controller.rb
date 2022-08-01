class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  def index
    @posts = Post.all
  end

  def edit
  end

  def show
  end

  def destroy
    @friend.destroy
    redirect_to friends_url, notice: "Friend was successfully destroyed."
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_url(@post), notice: 'post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post), notice: 'post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:caption, :user_id, :images)
    end
end
