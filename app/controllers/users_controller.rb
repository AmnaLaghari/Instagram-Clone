# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  private
  def set_post
    @user = User.find(params[:id])
  end
end
