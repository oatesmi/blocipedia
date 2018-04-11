class CollaboratorsController < ApplicationController
  before_action :authenticate_user!

  def new
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator_user = User.find_by_email(params[:collaborator])
    @collaborator = Collaborator.new(user_id: @collaborator_user.id, wiki_id: @wiki.id)

    if @collaborator.save
      redirect_to @wiki
      flash[:notice] = "Collaborator added."
    else
      redirect_to @wiki
      flash[:alert] = "Failed to add collaborator."
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @wiki = collaborator.wiki
    if @collaborator.destroy
      redirect_to @wiki
      flash[:notice] = "Collaborator removed."
    else
      redirect_to @wiki
      flash[:alert] = "Failed to remove collaborator."
    end
  end

end
