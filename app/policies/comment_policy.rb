# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
  end

  attr_reader :post, :record

  def index?
    user_exist? && record_not_nil?
  end

  def new?
    user_exist? && record_not_nil? && @user.following?(@post.user)
  end

  def create?
    user_exist? && record_not_nil? && (@user.following?(@post.user) || !check_private? || user_is_owner_ofrecord?)
  end

  def update?
    user_exist? && record_not_nil? && user_is_owner_ofrecord?
  end

  def destroy?
    user_exist? && record_not_nil? && user_is_owner_ofrecord?
  end
end
