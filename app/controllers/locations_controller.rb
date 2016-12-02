class LocationsController < ApplicationController

  def index
    @locations = Location.includes(:indoor_location).all
  end

  def show
    @location = Location.find(params[:id]).includes(:indoor_location)
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.CreatorID = session[:cas_user]
    @location.CreateTime = DateTime.now
    if @location.save
      redirect_to location_url(@location)
    else
      render action: :new
    end
  end

  private

  def location_params
    params.require(:location).permit(:Description, :Latitude, :Longitude, :IndoorID)
  end

end
