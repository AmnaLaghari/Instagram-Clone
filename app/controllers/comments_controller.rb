# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post, only: %i[create show edit update destroy]
  before_action :set_comment, only: %i[show edit update destroy]
  after_action :verify_authorized

  def show; end

  def edit; end

  def new
    @comment = Comment.new
    authorize @comment
  end

  def create
    @comment = @post.comments.new(comment_params)
    authorize @post
    if @comment.save
      render 'create', flash: { notice: 'Comment Added!' }
    else
      redirect_to post_url(@post), notice: @comment.errors.full_messages.to_sentence.to_s

    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: 'Comment was successfully updated. '
    else
      redirect_to edit_post_comment_url, notice: @comment.errors.full_messages.to_sentence.to_s
    end
  end

  def destroy
    if @comment.destroy
      redirect_to @post, notice: 'Comment was successfully deleted.'
    else
      redirect_to comments_url, notice: @comment.errors.full_messages.to_sentence.to_s
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id, [:comment])
  end

  def set_post
    @post = Post.find(params[:post_id])
    authorize @post
  end

  def set_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end
end
