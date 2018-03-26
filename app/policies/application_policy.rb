class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    user.try(:admin?) || user.try(:premium?)
  end

  def new?
    user.try(:admin?) || user.try(:premium?)
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    record.user == user || user.try(:admin?)
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
