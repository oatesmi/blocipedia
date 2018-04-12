class CollaboratorsController < ApplicationController
  before_action :authenticate_user!

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.where('email LIKE ?', "%#{params[:search]}%").first

    if @user
      unless @wiki.collaborators.pluck(:user_id).include?(@user)
        @collaborator = Collaborator.new(user_id: @user.id, wiki_id: @wiki.id)
      else
        flash[:alert] = "That user is already a collaborator."
        redirect_back(fallback_location: @wiki)
        return
      end
    else
      flash[:alert] = "No user matched."
      redirect_back(fallback_location: @wiki)
      return
    end

    if @collaborator.save
      flash[:notice] = "#{@user.username} has been added."
    else
      flash[:alert] = "here was an error adding the collaborator. Try again."
    end

    redirect_back(fallback_location: @wiki)
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find(@collaborator.user_id)

    if @collaborator.destroy
      redirect_to edit_wiki_path(@wiki.id)
    else
      flash.now[:alert] = "Error. Can't remove from this wiki."
      redirect_to edit_wiki_path(@wiki.id)
    end
  end
end
