# frozen_string_literal: true

class LikesController < ApplicationController
  after_action :verify_authorized

  def create
    @like = current_user.likes.new(like_params)
    @post = @like.post
    authorize @like
    authorize @post
    if @like.save
      render 'create'
    else
      flash[:notice] = @like.errors.full_messages.to_sentence.to_s
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    authorize @like
    if @like.destroy
      redirect_back fallback_location: users_path
    else
      redirect_back fallback_location: users_path,
                    notice: @like.errors.full_messages.to_sentence.to_s
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
