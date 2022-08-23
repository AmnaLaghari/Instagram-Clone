# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def index?
    user_exist?
  end

  def show?
    user_exist?
  end

  def search?
    user_exist?
  end
end
