# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
  class Scope < Scope
  end

  def create?
    user_exist? && record_not_nil? && (@user.following?(User.find(@record.user_id)) ||
                                          !check_private? || user_is_owner_ofrecord?)
  end

  def destroy?
    user_exist? && record_not_nil? && user_is_owner_ofrecord?
  end
end
