class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.private ? (user.admin? || (record.user == user)) : user.present?
  end

  def new?
    user.present?
  end

  def create?
    new?
  end

  def edit?
    show?
  end

  def update?
    edit?
  end

  def destroy?
    record.user == user || user.try(:admin?)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user
        return @scope.all
      else
        return @scope.none
      end
    end
  end
end
