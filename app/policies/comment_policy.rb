# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
  end

  attr_reader :post, :record

  def index?
    user.present?
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    user == @record.user
  end

  def destroy?
    return true if user.present? && user == @record.user
  end
end
