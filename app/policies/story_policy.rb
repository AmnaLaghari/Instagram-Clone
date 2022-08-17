# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def index
    user.present?
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def show?
    user_is_owner_ofrecord?
  end

  def destroy?
    user_is_owner_ofrecord?
  end

  private

  def user_is_owner_ofrecord?
    user == @record.user
  end
end
