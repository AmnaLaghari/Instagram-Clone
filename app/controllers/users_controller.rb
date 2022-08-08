# frozen_string_literal: true

class UsersController < ApplicationController
<<<<<<< HEAD
  before_action :set_user, only: %i[show]

=======
>>>>>>> Comments styling
  def index
    @users = User.all
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
