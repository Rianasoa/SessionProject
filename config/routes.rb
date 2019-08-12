Rails.application.routes.draw do
  root 'pages#index'
  get '/team', to: 'pages#team'
  get '/contact', to: 'pages#contact'

  get '/welcome/:first_name' , to: 'pages#index_logged', as: 'index_logged'

  resources :gossips
  resources :users
  resources :cities
  resources :comments
  resources :sessions, only: [:new, :create, :destroy]
  #only: [:new, :create, :index, :destroy]
  #except: [:destroy] 
end
