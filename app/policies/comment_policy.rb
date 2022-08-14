class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
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
