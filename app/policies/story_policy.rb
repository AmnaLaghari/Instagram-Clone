# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  include ApplicationHelper
  class Scope < Scope
  end

  def index?
    user_exist? && record_not_empty? && (@user.following?(user_details(@record.first.user_id)) ||
                                          check_id? || check_public?)
  end

  def create?
    user_exist? && record_not_nil?
  end

  def show?
    user_exist? && record_not_nil? && user_is_owner_ofrecord?
  end

  def destroy?
    user_exist? && record_not_nil? && user_is_owner_ofrecord?
  end

  private

  def check_public?
    @record.first.user.privacy.eql? 'Public'
  end

  def check_id?
    @user.id.eql? @record.first.user_id
  end
end
