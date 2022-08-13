# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_query

  def set_query
    @query = User.ransack(params[:q])
  end

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_url, alert: "You dont have access to this page"
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
