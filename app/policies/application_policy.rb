# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def user_exist?
    !@user.eql? nil
  end

  def record_not_nil?
    !@record.nil?
  end

  def record_not_empty?
    !record.empty?
  end

  def check_private?
    @record.user.privacy == 'Private'
  end

  def user_is_owner_ofrecord?
    @user.eql? @record.user
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
