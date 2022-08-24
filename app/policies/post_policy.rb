# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def index?
    user_exist?
  end

  def show?
    user_exist? && record_not_nil? && (@user.following?(@record.user) || !check_private? || @user == @record.user)
  end

  def create?
    record_not_nil? && user_exist?
  end

  def update?
    user_exist? && record_not_nil? && user_is_owner_ofrecord?
  end

  def destroy?
    user_exist? && record_not_nil? && user_is_owner_ofrecord?
  end

  def destroy_comment?
    user == @record.user
  end
end
