# frozen_string_literal: true

class RequestPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def index?
    user_exist? && record_not_nil?
  end

  def create?
    @user.id.eql? @record.sender_id if user_exist? && record_not_nil?
  end

  def edit?
    @user.id.eql? @record.reciever_id if user_exist? && record_not_nil?
  end

  def destroy?
    @user.id.eql? @record.reciever_id if user_exist? && record_not_nil?
  end
end
