class RequestsController < ApplicationController
  before_action :set_user, only: %i[check_request destroy create check_follow]
  before_action :check_request, only: [:create]
  before_action :check_follow, only: [:accept_request]

  def index
    @requests = Request.all
  end

  def create
    if current_user.send_request(@user)
      redirect_to user_path(@user.id), notice: 'Request sent successfully'
    else
      redirect_to user_path(@user.id), notice: "Request cannot be send due to some issue."
    end
  end

  def accept_request
    @user = User.find(params[:sender_id])
    ActiveRecord::Base.transaction do
      if current_user.following_users.create!(follower_id: @user.id)
        @user.delete_request(current_user)
        redirect_to user_path(@user.id), notice: 'Request accepted successfully'
      else
        redirect_to user_path(@user.id), notice: "Request was not accepted successfully.#{followed_users.errors.full_messages.to_sentence}"
      end
    end
    rescue ActiveRecord::RecordInvalid
      redirect_to user_path(@user.id), notice: 'Something went wrong.'
  end

  def destroy

    if current_user.delete_request(@user)
      redirect_to user_path(@user.id)
    else
      redirect_to user_path(@user.id), notice: 'Request was not deleted due to some issue.'
    end
  end

  private

  def check_request
    if current_user.sent_requests.include?(@user)
      redirect_to user_path(@user.id), notice: 'You have already requested to follow this user.'
    end
  end

  def check_follow
    if current_user.following?(@user)
      redirect_to user_path(@user.id), notice: 'You are already following this user'
    end
  end

  def set_user
    @user = User.find(params[:reciever_id])
  end
end
