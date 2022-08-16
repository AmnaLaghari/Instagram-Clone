# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def create
    @like = current_user.likes.new(like_params)
    authorize @like
    flash[:notice] = "Post not liked successfully #{@like.errors.full_messages.to_sentence}" unless @like.save
    respond_to do |format|
      format.html { redirect_back fallback_location: users_path }
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    authorize @like
    if @like.destroy
      respond_to do |format|
        format.html { redirect_back fallback_location: users_path }
      end
    else
      redirect_back fallback_location: users_path, notice: "Post is not unliked successfully. #{@like.errors.full_messages.to_sentence}"

    end
  end
  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
