class UsersController < ApplicationController

  before_action :set_user, only: [:show,:update,:edit,:destroy]
  before_action :set_cities, only: [:new,:create,:edit,:update]
  before_action :authenticate_user, except: [:new, :create]

  def index
  end

  def show
    @gossips_by_user = Gossip.where(user: params[:id]).order(updated_at: :desc)
    @column_names = []
    column_not_to_display = ["id","password_digest"]
    User.column_names.each do |c_name|
      if !column_not_to_display.include?(c_name) && !/_id/.match?(c_name)
        @column_names << c_name
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    hash_params = params.require(:user).permit(:first_name,:last_name,:email,:age,:city_id,:description,:password,:password_confirmation)
    # BESOIN DE VERIFIER SI LE COUPLE NOM/PRENOM EXISTE DEJA ???
    puts hash_params
    @user = User.new(hash_params)
    if @user.save
      log_in(@user)
      redirect_to index_logged_path(@user.first_name), success: "Compte créé avec succès"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  ###############################  METHODES PRIVEES 
  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_cities
    @cities=[]
    City.all.each do |city|
      @cities << [city.city_name,city.id]
    end
  end

  def authenticate_user
    unless current_user
      redirect_to root_path, danger: "Merci de vous identifier"
    end
  end

end