class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[create destroy]

  def index
    @requests = Request.all
  end

  def create
    current_user.send_request(@user)
    redirect_to user_path(@user.id)
  end

  def accept_request
    @user = User.find(params[:requester_id])
    current_user.followed_users.create(followee_id: @user.id)
    redirect_to user_path(@user.id)
  end

  def destroy
    current_user.delete_request(@user)
    redirect_to user_path(@user.id)
  end

  private
  def set_user
    @user = User.find(params[:reciever_id])
  end
end
