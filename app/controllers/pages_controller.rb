class PagesController < ApplicationController

  before_action :authenticate_user, only: [:index_logged]

  #Index général = page d'acceuil sans identification
  def index
    @gossips = Gossip.order(updated_at: :desc)
  end

  #Index personnalisé = page d'acceuil avec identification
  def index_logged
      @user_logged = current_user
      @gossips_by_user = Gossip.where(user: current_user).order(updated_at: :desc)
      @column_names = []
      column_not_to_display = ["id","password_digest"]
      User.column_names.each do |c_name|
        if !column_not_to_display.include?(c_name) && !/_id/.match?(c_name)
          @column_names << c_name
        end
      end
  end

  #Page permettant la présentation del'équipe
  def team
  end

  #Page permettant de prendre contact avec l'équipe
  def contact
  end

  private 

  def authenticate_user
    unless current_user
      redirect_to root_path, danger: "Merci de vous identifier"
    end
  end

end
