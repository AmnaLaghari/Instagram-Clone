class PostPolicy < ApplicationPolicy
  class Scope < Scope

    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user_id: @user.try(:id))
    end
  end

  def new?
    user.present?
  end

  def create?
    user.present?
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
