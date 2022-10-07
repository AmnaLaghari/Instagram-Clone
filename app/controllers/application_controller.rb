# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  include PunditExceptionHandling

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    redirect_back(fallback_location: root_path, notice: 'You are not authorized to perform this action.')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :full_name, :username, :privacy, :password, :bio, :avatar)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :password, :current_password, :full_name, :username, :privacy, :bio, :avatar,
               :password_confirmation)
    end
  end
end
