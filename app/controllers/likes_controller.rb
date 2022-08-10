class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    if !@like.save
      flash[:notice] = @like.errors.full_messages.to_sentence
    end
    respond_to do |format|
      format.html { redirect_back fallback_location: users_path }
    end
  end
  def destroy
    @like = current_user.likes.find(params[:id])
    post = @like.post
    @like.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: users_path }
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
