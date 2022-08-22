# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
  class Scope < Scope
  end

  def create?
    if user_exist? && record_not_nil? && (@user.following?(User.find(@record.user_id)) || !check_private? || user_is_owner_ofrecord?)
      true
    end
  end

  def destroy?
    true
    # if user_exist? && record_not_empty?
    #   return true if user_is_owner_ofrecord?
    # end
  end
end
