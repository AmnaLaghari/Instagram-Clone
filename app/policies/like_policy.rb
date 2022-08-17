# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
  class Scope < Scope
  end

  def create?
    user.present?
  end

  def destroy?
    user.present?
  end
end
