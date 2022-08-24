# frozen_string_literal: true

module ApplicationHelper
  def user_details(id)
    User.find(id)
  end
end
