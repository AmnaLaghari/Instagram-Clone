# frozen_string_literal: true

module PunditExceptionHandling
  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError, with: :handle_authorization_error
  end

  private

  def handle_authorization_error
    redirect_to root_url, alert: 'You dont have access to this page'
  end
end
