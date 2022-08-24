# frozen_string_literal: true

class RelationshipPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def create?
    user_exist? && record_not_nil?
  end

  def destroy?
    user_exist? && record_not_nil?
  end
end
