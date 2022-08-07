class CommentsController < ApplicationController
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

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end

end
