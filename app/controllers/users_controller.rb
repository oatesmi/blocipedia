class UsersController < ApplicationController
  before_action :authenticate_user!

  def downgrade
    current_user.wikis.each do |wiki|
      wiki.private = false
    end
    current_user.standard!
    redirect_to root_path
  end
end
