class WikiPolicy < ApplicationPolicy

  def index
    true
  end

  def show
    true
  end

  def new
    user.present?
  end

  def create
    user.present?
  end

  def edit
    update?
  end

  def update
    user.present?
  end

  def destroy
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
