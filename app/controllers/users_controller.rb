# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  after_action :verify_authorized

  def index
    @users = User.all
    authorize @users
  end

  def show; end

  def search
    @users = User.name_search(params[:q])
    authorize @users
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
