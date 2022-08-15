# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user


  def create
    if current_user.followed_users.create(followee_id: @user.id)
      redirect_to user_url(@user.id), notice: 'You have started following this user.'
    else
      redirect_to user_url(@user.id), notice: "You were not able to folloe this user. #{@user.errors.full_messages.to_sentence}"
    end
  end

  def destroy
    if current_user.unfollow(@user)
      redirect_to user_url(@user.id), notice: 'You are now not following this user.'
    else
      redirect_to user_url(@user.id),
                  notice: "You were not able to unfollow this user. Please try again.#{@user.errors.full_messages.to_sentence} "
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
