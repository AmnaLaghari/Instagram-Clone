# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :set_user
  after_action :verify_authorized

  def create
    @relationship = current_user.followed_users.new(followee_id: @user.id)
    authorize @relationship
    if @relationship.save
      redirect_to user_url(@user.id), notice: 'You have started following this user.'
    else
      redirect_to user_url(@user.id),
                  notice: @user.errors.full_messages.to_sentence.to_s
    end
  end

  def destroy
    @relationship = current_user.followed_users.find_by(followee_id: @user.id)
    authorize @relationship
    if @relationship.destroy
      redirect_to user_url(@user.id), notice: 'You are now not following this user.'
    else
      redirect_to user_url(@user.id),
                  notice: @user.errors.full_messages.to_sentence.to_s
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
