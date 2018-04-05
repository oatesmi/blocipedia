class UsersController < ApplicationController
  before_action :authenticate_user!

  def downgrade
    @user = current_user
    current_user.role = 'standard'
    wikis_private = Wiki.where(private: true, user: current_user)

    if @user.save
      wikis_private.update_all(private: false)
      flash[:notice] = "You are now a standard member.  All private wikis are now public."
      redirect_to downgrade_to_standard_path
    else
      flash.now[:alert] = "Can't downgrade your account. Try again."
      redirect_to wikis_path
    end
  end
end
