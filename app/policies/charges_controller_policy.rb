class ChargesControllerPolicy

  attr_reader :user, :ctrlr

  def initialize(user, ctrlr)
    @user = user
    @ctrlr = ctrlr
  end

  def new?
    user.try(:standard?)
  end

  def create?
    new?
  end

  def downgrade_to_standard?
    user.try(:premium?)
  end

end
