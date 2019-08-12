class GossipsController < ApplicationController

  before_action :set_gossip, only: [:show,:update,:edit,:destroy]
  before_action :set_tags, only: [:new,:create,:edit,:update]
  before_action :authenticate_user, only: [:show, :new, :create]
  before_action :authenticate_user_permission, only: [:edit,:update,:destroy]


  def show
  end

  def new
    @gossip = Gossip.new
  end

  def create
    hash_params = params.require(:gossip).permit(:title, :content, tag_ids: [])
    hash_params[:user_id] = current_user.id
    @gossip = Gossip.new(hash_params)
    if @gossip.save
      redirect_to root_path, success: "Potin créé avec succès"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    hash_params = params.require(:gossip).permit(:title, :content, tag_ids: [])
    if @gossip.update(hash_params)
      redirect_to gossip_path(@gossip.id), success: "Potin modifié avec succès"
    else
      render 'edit'
    end
  end

  def destroy
    @gossip.destroy
    redirect_to request.referrer, success:"Potin supprimé avec succès"
  end

  private

  def set_gossip
    @gossip = Gossip.find(params[:id])
  end

  def set_tags
    @tags=[]
    Tag.all.each do |tag|
      @tags << [tag.content,tag.id]
    end
  end

  def authenticate_user
    unless current_user
      redirect_to root_path, danger: "Merci de vous identifier"
    end
  end

  def set_gossip
    @gossip = Gossip.find(params[:id])
  end

  def authenticate_user_permission
    set_gossip
    unless current_user && @gossip.user == current_user
      redirect_to root_path, danger: "Action non authorisé ! Vous n'êtes pas l'auteur."
    end
  end


end