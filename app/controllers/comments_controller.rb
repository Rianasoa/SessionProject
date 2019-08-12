class CommentsController < ApplicationController

  before_action :authenticate_user, only: [:create]
  before_action :authenticate_user_permission, only: [:update,:edit,:destroy]
  # On ne peut pas gérer le CRUD des commentaires si on est pas loggué et propriétaire du commentaire

  def edit
  end

  def update
    hash = params[:new_comment]
    hash_params = hash.permit(:content)
    if @comment.update(hash_params)
      redirect_to index_logged_path(@comment.user.first_name), success: "Commentaire modifié avec succès"
    else
      render 'edit'
    end
  end

  def create
    hash = params[:new_comment]
    hash[:user_id] = current_user.id
    hash_params = hash.permit(:content,:user_id,:gossip_id)
    @comment = Comment.new(hash_params)
    if @comment.save
      redirect_to request.referrer, success: "Commentaire créé avec succès"
    else
      redirect_to request.referrer, danger: "Commentaire ne respéctant pas la taille limite"
    end
  end

  def destroy
    @comment.destroy
    flash[:success] ="Commentaire supprimé avec succès"
    redirect_to request.referrer
  end

  ########################################## Méthodes privées
  private

  def authenticate_user
    unless current_user
      redirect_to root_path, danger: "Merci de vous identifier"
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authenticate_user_permission
    set_comment
    unless current_user && @comment.user == current_user
      redirect_to root_path, danger: "Action non authorisé ! Vous n'êtes pas l'auteur."
    end
  end

end