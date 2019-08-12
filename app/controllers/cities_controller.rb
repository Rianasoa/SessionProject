class CitiesController < ApplicationController

  before_action :set_city, only: [:show,:update,:edit,:destroy]

  def index
  end

  def show
    @users_by_city = User.where(city: @city).order(created_at: :asc)
    @gossips_by_city = []
    @users_by_city.each do |user|
      @gossips_by_city.concat(user.gossips)
    end
  end


  private

  def set_city
    @city = City.find(params[:id])
  end

end