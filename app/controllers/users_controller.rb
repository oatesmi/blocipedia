class UsersController < ApplicationController
  before_action :authenticate_user!

  def downgrade
    current_user.standard!
    redirect_to downgrade_confirmation_path
  end
end
