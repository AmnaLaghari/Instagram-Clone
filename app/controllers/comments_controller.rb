class CommentsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_comment, only: %i[show edit update destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def edit
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.save
      redirect_to post_url(@post), notice: 'comment was successfully created.'
    else
      flash[:alert] = "Your comment was not saved successfuly. Please try again #{comment.errors}"
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: 'Comment was successfully updated.'
    else
      render 'edit', notice: 'Something went wrong'
    end
  end

  def destroy
    if @comment.destroy
      redirect_to @post, notice: 'Comment was successfully deleted.'
    else
      redirect_to comments_url, notice: 'Something went wrong'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id, [:comment])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
