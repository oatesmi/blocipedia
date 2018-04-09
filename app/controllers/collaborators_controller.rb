class CollaboratorsController < ApplicationController
  def new
    @collaborator = Collaborator.new
  end

  def create
    collaborator_user = User.find_by_email(params[:collaborator])
    wiki = Wiki.find(params[:wiki_id])
    if wiki.collaborators.exists?(user_id: collaborator_user.id)
      flash[:notice] = "This collaborator was already added."
      redirect_to wiki
    else
      collaborator = Collaborator.new(user_id: collaborator_user.id, wiki_id: wiki.id)
      if collaborator.save
        flash[:notice] = "Collaborator added."
      else
        flash[:alert] = "Failed to add collaborator."
      end
      redirect_to wiki
    end
  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    collaborator = Collaborator.find(params[:id])
    collaborator_user = User.find(collaborator.user_id)

    if collaborator.destroy
      flash[:notice] = "Collaborator removed."
    else
      flash[:alert] = "Failed to remove collaborator."
    end
    redirect_to wiki
  end
end
