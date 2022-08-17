# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def index?
    user.present?
  end

  def new?
    @user.present?
  end

  def show?
    @user.present?
  end

  def create?
    @record.present?
  end

  def update?
    user_is_owner_ofrecord?
  end

  def destroy?
    user_is_owner_ofrecord?
  end

  def destroy_comment?
    user == @record.user
  end

  private

  def user_is_owner_ofrecord?
    user == @record.user
  end
end
