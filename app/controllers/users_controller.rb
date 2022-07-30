# frozen_string_literal: true

class UsersController < ApplicationController
  # protect_from_forgery with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?
  def index
    @users = Users.all
  end

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up) do |u|
  #     u.permit(:email, :full_name, :username, :privacy, :password, :bio)
  #   end
  #   devise_parameter_sanitizer.permit(:account_update) do |u|
  #     u.permit(:email, :password, :full_name, :username, :privacy, :bio)
  #   end
  # end
end
