# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def index?
    user_exist?
  end

  def show?
    if user_exist? && record_not_nil? && (@user.following?(@record.user) || !check_private? || @user == @record.user)
      true
    end
  end

  def create?
    return true if record_not_nil? && user_exist?
  end

  def update?
    return true if user_exist? && record_not_nil? && user_is_owner_ofrecord?
  end

  def destroy?
    return true if user_exist? && record_not_nil? && user_is_owner_ofrecord?
  end

  def destroy_comment?
    user == @record.user
  end
end
