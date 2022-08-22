# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
  end

  attr_reader :post, :record

  def index?
    return true if user_exist? && record_not_nil?
  end

  def new?
    return true if user_exist? && record_not_nil? && @user.following?(@post.user)
  end

  def create?
    if user_exist? && record_not_nil? && (@user.following?(@post.user) || !check_private? || user_is_owner_ofrecord?)
      true
    end
  end

  def update?
    return true if user_exist? && record_not_nil? && user_is_owner_ofrecord?
  end

  def destroy?
    return true if user_exist? && record_not_nil? && user_is_owner_ofrecord?
  end
end
