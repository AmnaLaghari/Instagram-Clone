# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def user_exist?
    user.present?
  end
end
