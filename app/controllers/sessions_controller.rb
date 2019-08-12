class SessionsController < ApplicationController


  #Création du cookie / Log-in
  def create
    session_params = params.require(:session).permit(:email, :password)
    user = User.find_by(email: session_params[:email])

    if user && user.authenticate(session_params[:password])
      log_in(user)
      redirect_to root_path, success: 'Identification réussie'
    else
      redirect_to root_path, danger: 'Combinaison email/password invalide'
    end
  end

    #Destruction du cookie / Log-out
  def destroy
    session.delete(:user_id)
    redirect_to root_path, success: 'Déconnexion réussie'
  end

end
