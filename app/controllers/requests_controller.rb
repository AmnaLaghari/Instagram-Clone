# frozen_string_literal: true

class RequestsController < ApplicationController
  include RequestsHelper
  before_action :set_user, only: %i[check_request destroy create check_follow]
  before_action :check_request, only: [:create]
  before_action :check_follow, only: [:edit]
  before_action :set_request, only: [:edit]

  def index
    @requests = Request.all
    authorize @requests
  end

  def create
    @request = current_user.sent_requests.new(reciever_id: @user.id)
    authorize @request
    if @request.save
      redirect_to user_path(@user.id), notice: 'Request sent successfully'
    else
      redirect_to user_path(@user.id),
                  notice: @request.errors.full_messages.to_sentence.to_s
    end
  end

  def edit
    @user = User.find(@request.sender_id)
    if current_user.accept_request(@user)
      redirect_to user_path(@user.id), notice: 'Request accepted successfully'
    else
      redirect_to user_path(@user.id),
                  notice: followed_users.errors.full_messages.to_sentence.to_s
    end
  end

  def destroy
    if current_user.delete_request(@user)
      redirect_to user_path(@user.id), notice: 'Request deleted successfully'
    else
      redirect_to user_path(@user.id), notice: 'Request was not deleted due to some issue.'
    end
  end

  private

  def check_request
    return unless current_user.sent_requests.include?(@user)

    redirect_to user_path(@user.id), notice: 'You have already requested to follow this user.'
  end

  def check_follow
    redirect_to user_path(@user.id), notice: 'You are already following this user' if current_user.following?(@user)
  end

  def set_user
    @user = User.find(params[:reciever_id])
  end

  def set_request
    @request = Request.find(params[:id])
  end
end
