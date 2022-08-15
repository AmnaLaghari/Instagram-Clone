# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show]

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @users = User.all
    @posts = policy_scope(Post).reverse
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
