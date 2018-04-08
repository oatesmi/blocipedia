class CollaboratorsController < ApplicationController
  before_action :set_collaborator, only: [:show, :edit, :update, :destroy]
  before_action :set_wiki, only: [:new, :create, :index]

  def index
    @collaborators = @wiki.collaborators
  end

  def show
  end

  def new
    @users = User.all
    @collaborator = @wiki.collaborators.new
  end

  def edit
  end

  def create
    # @wiki = Wiki.find(params[:wiki_id])
    # @user = User.where(username: params[:username]).take
    @collaborator = @wiki.collaborators.build(collaborator_params)

    if @collaborator.save
      flash[:notice] = "Collaborator was successfully created."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error saving the collaborator. Please try again."
      render :new
    end

    # if @user == nil
    #   flash[:error] = "That user could not be found."
    #   redirect_to edit_wiki_path(@wiki)
    # else
    #   collaborator = @wiki.collaborators.build(user_id: @user_id)
    #   if collaborator.save
    #     flash[:notice] = "#{@user.username} has been added to the wiki."
    #     redirect_to edit_wiki_path(@wiki)
    #   else
    #     flash[:error] = "That user could not be added."
    #     redirect_to edit_wiki_path(@wiki)
    #   end
    # end
  end

  def update
    @collaborator.update_attributes(collaborator_params)

    if @collaborator.save
      flash[:notice] = "Collaborator was successfully updated."
      redirect_to @collaborator
    else
      flash[:alert] = "There was an error updating the collaborator. Please try again."
      render :edit
    end
  end

  def destroy
    # @collaborator = Collaborator.find(params[:id])
    # wiki_id = @collaborator.wiki_id
    # col_user = User.find(@collaborator.user_id)

    if @collaborator.destroy
      flash[:notice] = "#{@collaborator.user.username} has been removed as a collaborator."
      redirect_to wiki_collaborators_path
    else
      flash.now[:alert] = "#{@collaborator.user.username} could not be removed."
      redirect_to wiki_collaborators_path
    end
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end

  def set_collaborator
    @collaborator = Collaborator.find(params[:id])
  end

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
