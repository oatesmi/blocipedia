class CollaboratorsController < ApplicationController
  before_action :authenticate_user!

  def new
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator_user = User.find_by_email(params[:collaborator])
    if @wiki.collaborators.exists?(user_id: @collaborator_user.id)
      flash[:notice] = "This collaborator has already been added."
      redirect_to @wiki
    else
      @collaborator = Collaborator.new(user_id: @collaborator_user.id, wiki_id: @wiki.id)
      if @collaborator.save
        redirect_to @wiki
        flash[:notice] = "Collaborator added."
      else
        redirect_to @wiki
        flash[:alert] = "Failed to add collaborator."
      end
    end
  end

  def destroy
    @cid = Collaborator.find(params[:id])

    if @cid.destroy
      flash[:notice] = "Collaborator removed."
    else
      flash[:alert] = "Failed to remove collaborator."
    end
    redirect_to @cid.wiki
  end

end
