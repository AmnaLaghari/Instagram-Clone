# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  def index
    @users = User.all
  end

  def show
    @posts = Post.find_by(user_id: params[:id])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
