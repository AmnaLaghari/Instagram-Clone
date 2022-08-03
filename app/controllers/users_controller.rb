# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_post, only: %i[show]
  # protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?
  def index
    @users = Users.all
  end

  def show
    @posts = Post.find_by(user_id: params[:id])
  end

  private
  def set_post
    @user = User.find(params[:id])
  end
end
